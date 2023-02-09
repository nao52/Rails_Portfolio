FactoryBot.define do
  factory :user do
    name                    { "michael" }
    sequence(:email)        { |n| "test#{n}@example.com" }
    password                { "password" }
    password_confirmation   { "password" }
    subject_id              { Subject.first.id }
    club_id                 { Club.first.id }
    kinds_of_school_id      { KindsOfSchool.first.id }
  end
end
