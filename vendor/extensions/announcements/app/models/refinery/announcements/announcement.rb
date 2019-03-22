module Refinery
  module Announcements
    class Announcement < Refinery::Core::BaseModel
      self.table_name = 'refinery_announcements'


      extend Mobility
      translates :title, :body

      validates :title, :presence => true, :uniqueness => true

      belongs_to :image, :class_name => '::Refinery::Image'

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
