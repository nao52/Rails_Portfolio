FactoryBot.define do
  factory :publisher do
    sequence(:name)   { |n| "テスト#{n}" }
    user_id           { User.first.id }
  end
end
