
FactoryBot.define do
  factory :weigh_in_prompt, :class => Refinery::WeighInPrompts::WeighInPrompt do
    sequence(:title) { |n| "WeighInPrompt#{n}" }
    body { "Share what you want the region to be like in 2050!" }
    style { :large }
    image
  end
end

