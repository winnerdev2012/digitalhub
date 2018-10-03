MAX_TRANSLATE_LENGTH = 5000

Refinery::Page.class_eval do

  after_save :translate_content

  protected

    def translate_content
      aws_translation_client = Aws::Translate::Client.new
      auto_translate_mobility_obj(aws_translation_client, self)
      for part in parts
        auto_translate_mobility_obj(aws_translation_client, part)
      end
    end

    def auto_translate_mobility_obj(client, obj)
      translations_required = []
      translatable_names = obj.translated_attribute_names.select { |name| !name.include?('slug') }
      for attribute_name in translatable_names
        for locale in Refinery::I18n.locales.keys
          if obj.send("#{attribute_name}_en") && !obj.send("#{attribute_name}_#{locale}")
            translations_required.push([attribute_name, locale])
          end
        end
      end

      for attribute_name, locale in translations_required
        attribute_value = obj.send("#{attribute_name}_en")
        translated_value = ""
        if attribute_value.length > MAX_TRANSLATE_LENGTH
          chunk_index = 0
          translated_chunks = []
          while attribute_value.length > 0
            if attribute_value.length > MAX_TRANSLATE_LENGTH
              chunk = attribute_value.slice(0, MAX_TRANSLATE_LENGTH * (chunk_index + 1)).match(/(^.*<\/[A-Za-z0-9]*>)/m).captures.last
              if attribute_value.length > 0 && !chunk
                chunk = attribute_value.slice(0, MAX_TRANSLATE_LENGTH * (chunk_index + 1)).match(/(^.*\s)/m).captures.last
              end
              attribute_value = attribute_value.slice(chunk.length, attribute_value.length) || ""
            else
              chunk = attribute_value
              attribute_value = ""
            end
            chunk_index += 1
            response = client.translate_text({
              text: chunk,
              source_language_code: "en",
              target_language_code: locale,
            })
            translated_chunks.push(response.translated_text)
          end
          translated_value = translated_chunks.join
        else
          response = client.translate_text({
            text: attribute_value,
            source_language_code: "en",
            target_language_code: locale,
          })
          translated_value = response.translated_text
        end
        obj.translations.in_locale(locale).send("#{attribute_name}=", translated_value)
        obj.translations.in_locale(locale).save!
      end
    end

end
