FactoryGirl.define do 
  factory :artist do
    name { Faker::Name.name}
    photo_url "http://google.com"
  end
end