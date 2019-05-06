require 'rails_helper'

RSpec.describe 'Weigh In Stories', :type => :system do
  it 'shows stories on the weigh in page', js: :true do
    create(:story, :with_video)
    create_list(:story, 2)
    create(:weigh_in_prompt, style: 'small')
    visit '/stories'
    expect(page).to have_css('div .story', count: 4)
  end
end
