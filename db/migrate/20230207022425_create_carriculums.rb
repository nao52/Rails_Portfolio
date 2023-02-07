class CreateCarriculums < ActiveRecord::Migration[7.0]
  def change
    create_table :carriculums do |t|
      t.string :name

      t.timestamps
    end
  end
end
