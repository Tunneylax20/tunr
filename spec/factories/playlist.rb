FactoryGirl.define do 
  factory :playlist do
    title { Faker::Lorem.words(3).join(" ") }
    association :user
  end
end