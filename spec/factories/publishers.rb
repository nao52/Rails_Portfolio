FactoryBot.define do
  factory :publisher do
    sequence(:name)   { |n| "ใในใ#{n}" }
  end
end
