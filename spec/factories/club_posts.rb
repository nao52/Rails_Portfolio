FactoryBot.define do
  factory :club_post do
    content { "テスト投稿です" }
    user_id { User.first.id }
    club_id { Club.first.id }
  end
end
