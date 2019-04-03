require 'spec_helper'

module Refinery
  module OneBoxes
    describe OneBox do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:one_box,
          :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
    end
  end
end
