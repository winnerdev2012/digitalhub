FactoryBot.define do
  factory :page, class: Refinery::Page do
    sequence(:title, "Welcome to MetroCommon 2050!") { |n| "Test title #{n}" }
    link_url { '/' }

    factory :page_with_page_part do
      after(:create) do |page|
        page.parts << FactoryBot.build(:page_part)
      end
    end
  end
end
