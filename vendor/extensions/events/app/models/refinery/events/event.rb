module Refinery
  module Events
    class Event < Refinery::Core::BaseModel
      extend Mobility
      self.table_name = 'refinery_events'
      acts_as_indexed :fields => [:title, :description]
      is_seo_meta
      translates :title, :description, :accessibility_note, :translation_note
      validates :title, :presence => true, :uniqueness => true
      validates :start, :presence => true
      belongs_to :image, :class_name => '::Refinery::Image', :optional => true
      after_save :translate_content

      has_many :taggings, :class_name => '::Refinery::Taggings::Tagging'
      has_many :tags, :class_name => '::Refinery::Tags::Tag', through: :taggings

      def self.tagged_with(title)
        Refinery::Tags::Tag.find_by_title!(title).events
      end

      def self.tag_counts
        Refinery::Tags::Tag.select("tags.*, count(taggings.tag_id) as count").
          joins(:taggings).group("taggings.tag_id")
      end

      def tag_list
        tags.map(&:title).join(", ")
      end

      def tag_list=(titles)
        self.tags = titles.split(",").map do |t|
          Refinery::Tags::Tag.where(title: t.strip).first_or_create!
        end
      end

      def tag_content_type
        self.tags.where(tag_type: "content_type")[0].title
      end

      def self.next_three_events
        next_three = ::Refinery::Events::Event.where('start > ?', DateTime.now).order(start: :asc).first(3)
        next_three_json = next_three.map {|event| EventSerializer.new(event, { :include => [:image] }).serializable_hash }
      end

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
