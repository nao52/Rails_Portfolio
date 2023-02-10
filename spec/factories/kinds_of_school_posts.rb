FactoryBot.define do
  factory :kinds_of_school_post do
    content             { "テスト投稿です" }
    user_id             { User.first.id }
    kinds_of_school_id  { KindsOfSchool.first.id }
  end
end
