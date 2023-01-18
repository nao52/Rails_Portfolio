class AddClubToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :club, null: false, foreign_key: true
  end
end
