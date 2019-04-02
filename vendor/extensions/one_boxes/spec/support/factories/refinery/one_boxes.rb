
FactoryBot.define do
  factory :one_box, :class => Refinery::OneBoxes::OneBox do
    sequence(:title) { |n| "refinery#{n}" }
    triangle_overlay { true }
    visible { true }
    link { "https://www.mapc.org/" }
    image
  end
end

