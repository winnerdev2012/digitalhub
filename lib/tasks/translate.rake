
namespace :translate do

  # Task derived from https://github.com/refinery/refinerycms-i18n/blob/master/lib/tasks/translate.rake#L130
  desc "Apply Amazon translate to auto translate all texts to all locales"
  task :amazon => :environment do
    aws_translation_client = Aws::Translate::Client.new
    I18n.backend.send(:init_translations) unless I18n.backend.initialized?

    # The following helper functions were pulled directly from https://github.com/refinery/refinerycms-i18n/
    # as part of Refinery's MIT license https://github.com/refinery/refinerycms/
    # Begin helper functions ---------------------------------------------------
    def deep_stringify_keys(hash)
      hash.inject({}) { |result, (key, value)|
        value = deep_stringify_keys(value) if value.is_a? Hash
        result[(key.to_s rescue key) || key] = value
        result
      }
    end

    def keys_to_yaml(keys)
      # Using ya2yaml, if available, for UTF8 support
      keys.respond_to?(:ya2yaml) ? keys.ya2yaml(:escape_as_utf8 => true) : keys.to_yaml
    end

    def extract_i18n_keys(hash, parent_keys = [])
      hash.inject([]) do |keys, (key, value)|
        full_key = parent_keys + [key]
        if value.is_a?(Hash)
          # Nested hash
          keys += extract_i18n_keys(value, full_key)
        elsif value.present?
          # String leaf node
          keys << full_key.join(".")
        end
        keys
      end
    end

    def deep_merge!(hash1, hash2)
      merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
      hash1.merge!(hash2, &merger)
    end

    def to_deep_hash(hash)
      hash.inject({}) do |deep_hash, (key, value)|
        keys = key.to_s.split('.').reverse
        leaf_key = keys.shift
        key_hash = keys.inject({leaf_key.to_sym => value}) { |hash, key| {key.to_sym => hash} }
        deep_merge!(deep_hash, key_hash)
        deep_hash
      end
    end

    def write_to_file(locale, keys)
      path = File.join(Translate.locales_dir, "#{locale}.yml")
      File.open(path, "w") do |file|
        file.puts keys_to_yaml(deep_stringify_keys(keys))
      end
    end
    # End helper functions -----------------------------------------------------

    from_lang = 'en'
    Refinery::I18n.frontend_locales.select { |lang| lang != :en }.each do |to_lang|
      start_at = Time.now
      translations = {}
      # Always translating from English
      keys = extract_i18n_keys(I18n.backend.send(:translations)[from_lang.to_sym]).sort
      keys.each do |key|
        from_text = I18n.backend.send(:lookup, from_lang, key).to_s
        to_text = I18n.backend.send(:lookup, to_lang, key)
        if !from_text.blank? && to_text.blank?
          print "#{key}: '#{from_text[0, 40]}' => "
          if !translations[from_text]
            response = aws_translation_client.translate_text({
              text: from_text,
              source_language_code: from_lang,
              target_language_code: to_lang,
            })
            translations[from_text] = response.translated_text
          end
          if !(translation = translations[from_text]).blank?
            translation.gsub!(/\(\(([a-z_.]+)\)\)/i, '{{\1}}')
            # Remove strange Proc call
            translation.gsub!(/!ruby\/object:Proc {}/i, '')
            puts "'#{translation[0, 40]}'"
            I18n.backend.store_translations(to_lang.to_sym, to_deep_hash({key => translation}))
          else
            puts "NO TRANSLATION - #{response.inspect}"
          end
        end
      end

      puts "\nTime elapsed: #{(((Time.now - start_at) / 60) * 10).to_i / 10.to_f} minutes"
      to_lang_sym = to_lang.to_sym
      write_to_file(to_lang_sym, {to_lang_sym => I18n.backend.send(:translations)[to_lang_sym]})
    end
  end
end
