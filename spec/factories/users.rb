FactoryBot.define do
  factory :user do
    name               { "taro" }
    sequence(:email)   { |n| "test#{n}@example.com" }
    password           { "password" }
    subject_id         { 1 }
    club_id            { 1 }
    kinds_of_school_id { 1 }
  end
end
