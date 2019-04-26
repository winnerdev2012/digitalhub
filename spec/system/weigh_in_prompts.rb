require "rails_helper"

RSpec.describe "Weigh In Prompts", :type => :system do
  it "displays a large weigh in prompt" do
    create_list(:story, 3)
    prompt1 = create(:weigh_in_prompt)
    visit "/stories"
    expect(page).to have_css('div.story--prompt-large')
  end

  it "displays a small weigh in prompt" do
    create_list(:story, 10)
    prompt1 = create(:weigh_in_prompt)
    prompt2 = create(:weigh_in_prompt, style: 'small')
    visit "/stories"
    expect(page).to have_css('div.story--prompt-small')
  end

  it "does not display small prompt with too few stories" do
    create_list(:story, 4)
    prompt1 = create(:weigh_in_prompt)
    prompt2 = create(:weigh_in_prompt, style: 'small')
    visit "/stories"
    expect(page).not_to have_css('div.story--prompt-small')
  end
end
