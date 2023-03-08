class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.integer :seat_no
      t.string :student_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
