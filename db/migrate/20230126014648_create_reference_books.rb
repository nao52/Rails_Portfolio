class CreateReferenceBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :reference_books do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reference_books, :title
  end
end
