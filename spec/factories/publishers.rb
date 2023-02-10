FactoryBot.define do
  factory :publisher do
    sequence(:name)   { |n| "テスト#{n}" }
  end
end
