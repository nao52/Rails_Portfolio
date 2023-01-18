class AddKindsOfSchoolToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :kinds_of_school, null: false, foreign_key: true
  end
end
