FactoryBot.define do
  factory :subject_post do
    content     { "テスト投稿です" }
    user_id     { User.first.id }
    subject_id  { Subject.first.id }
  end
end
