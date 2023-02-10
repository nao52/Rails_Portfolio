FactoryBot.define do
  factory :book_review do
    content           { "テストレビューです" }
    user_id           { User.first.id }
    reference_book_id { ReferenceBook.first.id }
  end
end
