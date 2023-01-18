class CreateKindsOfSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :kinds_of_schools do |t|
      t.string :name

      t.timestamps
    end
  end
end
