class AddSubjectIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subject_id, :integer
  end
end
