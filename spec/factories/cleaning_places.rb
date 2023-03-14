FactoryBot.define do
  factory :cleaning_place do
    sequence(:name)         { |n| "student(#{n})" }
    boys_num { 3 }
    girls_num { 3 }
  end
end
