require 'rails_helper'

RSpec.describe 'Weigh In Stories', :type => :system do
  it 'sizes flexbox container correctly with 4 objects', js: :true do
    create(:story, :with_video)
    create_list(:story, 2)
    create(:weigh_in_prompt, style: 'small')
    visit '/stories'
    Capybara.current_session.driver.browser.manage.window.resize_to(1281, 1000)

    expect(page).to have_xpath('//section[@id="stories"][@style="height: 784px;"]')
  end
end
