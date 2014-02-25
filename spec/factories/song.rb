FactoryGirl.define do
  factory :song do
    title { Faker::Lorem.words(3).join(" ") }
    price 1.99
    association :artist
  end
end