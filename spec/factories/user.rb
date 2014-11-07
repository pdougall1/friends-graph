FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "adama#{n}@caprica.gov" }
    sequence(:first_name) { "example" }
    sequence(:last_name) { |n| "user" }
    sequence(:linkedin_id) { |n| "some_id" }
  end
end
