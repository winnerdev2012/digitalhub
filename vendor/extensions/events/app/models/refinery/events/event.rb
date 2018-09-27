module Refinery
  module Events
    class Event < Refinery::Core::BaseModel
      extend Mobility
      self.table_name = 'refinery_events'
      acts_as_indexed :fields => [:title, :description]
      is_seo_meta
      translates :title, :description, :accessibility_note, :translation_note
      validates :title, :presence => true, :uniqueness => true
      belongs_to :image, :class_name => '::Refinery::Image'
      after_save :translate_content

      protected

        def translate_content
          aws_translation_client = Aws::Translate::Client.new
          auto_translate_mobility_obj(aws_translation_client, self)
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
            response = client.translate_text({
              text: obj.send("#{attribute_name}_en"),
              source_language_code: "en",
              target_language_code: locale,
            })
            obj.translations.in_locale(locale).send("#{attribute_name}=", response.translated_text)
            obj.translations.in_locale(locale).save!
          end
        end


    end
  end
end
