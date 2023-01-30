class AddLikesCountToReferenceBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :reference_books, :likes_count, :integer, null: false, default: 0
    add_index :reference_books, [:likes_count]
  end

end
