class CreateWorksheets < ActiveRecord::Migration[7.0]
  def change
    create_table :worksheets do |t|
      t.string :name
      t.text :detail
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :worksheets, [:user_id, :created_at]
  end
end
