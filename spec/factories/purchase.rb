FactoryGirl.define do
  factory :purchase do
    association :song
    association :user
  end
end