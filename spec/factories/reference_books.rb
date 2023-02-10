FactoryBot.define do
  factory :reference_book do
    title         { "書籍タイトル" }
    user_id       { User.first.id }
    publisher_id  { Publisher.first.id }
    likes_count   { 0 }
  end
end
