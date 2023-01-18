class AddSubjectToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :subject, null: false, foreign_key: true
  end
end
