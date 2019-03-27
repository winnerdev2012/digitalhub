require 'spec_helper'

module Refinery
  module HeroImages
    describe HeroImage do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:hero_image,
          :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
    end
  end
end
