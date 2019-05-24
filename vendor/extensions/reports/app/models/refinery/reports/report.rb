module Refinery
  module Reports
    class Report < Refinery::Core::BaseModel
      self.table_name = 'refinery_reports'


      validates :title, :presence => true, :uniqueness => true

      belongs_to :image, :class_name => '::Refinery::Image'

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
