Refinery::PagesController.class_eval do
  before_action :fetch_events, :only => [:show]

  def fetch_events
    puts "TEST TEST TEST TEST TEST"
    puts @page.view_template
    # @events = ::Refinery::Events::Event.all
  end
  protected :fetch_events
end
