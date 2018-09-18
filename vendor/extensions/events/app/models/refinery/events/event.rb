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
    end
  end
end
