require 'spec_helper'

module Refinery
  module Taggings
    describe Tagging do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:tagging)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
