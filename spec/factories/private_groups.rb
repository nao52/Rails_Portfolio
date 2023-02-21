FactoryBot.define do
  factory :private_group do
    sequence(:name)        { |n| "プライベートグループ#{n}" }
  end
end
