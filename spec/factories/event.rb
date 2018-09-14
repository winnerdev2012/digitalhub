require 'faker'
FactoryBot.define do
  factory :refinery_event do
    start { "John" }
    add_attribute(:end)  { "Doe" }
    admin { false }
    image_id
    event_type
    address
    city
    state
    zipcode
    registration_link
    position
  end
end
