class CreateWorksheetFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :worksheet_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :worksheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
