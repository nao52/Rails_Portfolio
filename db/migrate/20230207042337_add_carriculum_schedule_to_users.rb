class AddCarriculumScheduleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :carriculum_schedule, :string, null: false, default: ""
  end
end
