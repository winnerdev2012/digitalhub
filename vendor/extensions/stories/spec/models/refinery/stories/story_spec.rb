require 'spec_helper'

module Refinery
  module Stories
    describe Story do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:story,
          :name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Refinery CMS" }
      end
    end
  end
end
