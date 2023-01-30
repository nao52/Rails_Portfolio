class AddLikesCountToWorksheets < ActiveRecord::Migration[7.0]
  def change
    add_column :worksheets, :likes_count, :integer, null: false, default: 0
    add_index :worksheets, [:likes_count]
  end
end
