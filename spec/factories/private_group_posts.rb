FactoryBot.define do
  factory :private_group_post do
    content           { "テスト投稿です" }
    user_id           { User.first.id }
    private_group_id  { PrivateGroup.first.id }
  end
end
