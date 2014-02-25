FactoryGirl.define do 
  factory :user do
    email { Faker::Internet.email } 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "jeff"
    password_confirmation "jeff"
    dob Date.today
    balance 10.00
  end
end