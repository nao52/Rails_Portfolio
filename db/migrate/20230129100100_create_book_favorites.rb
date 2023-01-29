class CreateBookFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :book_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reference_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
