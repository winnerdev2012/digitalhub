require "rails_helper"

RSpec.describe "One boxes", :type => :system do
  it "displays a box for each one box" do
    create(:page)
    one_box = create(:one_box)
    visit "/"
    expect(page).to have_content(one_box.title)
  end

  it "displays the boxes in order" do
    create(:page)
    one_box2 = create(:one_box, position: 2)
    one_box1 = create(:one_box, position: 1)
    visit "/"
    expect(all('.styled-box__title')[0]&.text).to have_text(one_box1.title)
    expect(all('.styled-box__title')[1]&.text).to have_text(one_box2.title)
  end

  it "does not display hidden boxes" do
    create(:page)
    one_box1 = create(:one_box, visible: false)
    visit "/"
    expect(all('.styled-box__title')[0]&.text).not_to have_text(one_box1.title)
  end
end
