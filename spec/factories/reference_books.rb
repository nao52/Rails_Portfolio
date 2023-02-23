FactoryBot.define do
  factory :reference_book do
    sequence(:title)        { |n| "書籍タイトル(#{n})" }
    likes_count   { 0 }
  end
end
