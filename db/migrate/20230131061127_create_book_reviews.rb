class CreateBookReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :book_reviews do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :reference_book, null: false, foreign_key: true

      t.timestamps
    end
    add_index :book_reviews, [:user_id, :created_at]
  end
end
