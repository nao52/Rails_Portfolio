class CreateCleaningPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :cleaning_places do |t|
      t.string :name
      t.integer :boys_num
      t.integer :girls_num
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
