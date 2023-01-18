class RemoveSubjectIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :subject_id, :integer
  end
end
