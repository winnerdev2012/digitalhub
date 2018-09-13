Refinery::PagesController.class_eval do
  before_action :fetch_events, :only => [:show]

  def fetch_events
    return unless @page.view_template == 'events'

    now = DateTime.now
    now_nozone = DateTime.new(now.year, now.month, now.day, now.hour, now.minute, now.second)
    in_next_year, next_month = (now_nozone.month + 1).divmod(12)
    year = in_next_year > 0 ? now_nozone.year + 1 : now_nozone.year
    beginning_of_next_month = DateTime.new(year, next_month, 1, 0, 0, 0)
    end_of_next_month = DateTime.new(year, next_month, -1, -1, -1, -1)

    @upcoming_events = ::Refinery::Events::Event.where(start: now_nozone..beginning_of_next_month)
    @events_next_month = ::Refinery::Events::Event.where(start: beginning_of_next_month..end_of_next_month)
  end
  protected :fetch_events
end
