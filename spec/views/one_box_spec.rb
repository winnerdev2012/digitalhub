require "rails_helper"

RSpec.describe "Partials", :type => :view do
  it "is a static box when given a type of half" do
    partial = render partial: '/partials/one_box', locals: {type: 'half', title: 'Process Details', image: 'norwood-person.jpg'}
    expect(partial).to include('styled-box--half')
  end

  it "hovers when you do not give it a type of half" do
    partial = render partial: '/partials/one_box', locals: {title: 'Process Details', image: 'norwood-person.jpg'}
    expect(partial).not_to include('styled-box--half')
  end
end
