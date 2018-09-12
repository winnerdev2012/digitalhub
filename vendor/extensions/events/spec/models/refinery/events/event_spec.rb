require 'spec_helper'

module Refinery
  module Events
    describe Event do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:event,
          :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
    end
  end
end
