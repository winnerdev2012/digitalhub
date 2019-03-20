Refinery::PagesController.class_eval do

  before_action :find_next_events, :only => [:home]

  protected

    def find_next_events
      now = DateTime.now
      now_nozone = DateTime.new(now.year, now.month, now.day, now.hour, now.minute, now.second)
      @next_events = ::Refinery::Events::Event.where("start > ?", now_nozone).order('start ASC')
    end

end
