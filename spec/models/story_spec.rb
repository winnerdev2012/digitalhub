require "rails_helper"

RSpec.describe Refinery::Stories::Story, :type => :model do
  context "with 0 previous models" do
    it "sets position to 0" do
      story = FactoryBot.create(:story, title: 'Test Title')
      expect(story.reload.position).to eq(0)
    end
  end

  context "with 1 previous model" do
    it "sets position to 1" do
      FactoryBot.create(:story, title: 'Story 1')
      story2 = FactoryBot.create(:story, title: 'Story 2')
      expect(story2.reload.position).to eq(1)
    end
  end
end
