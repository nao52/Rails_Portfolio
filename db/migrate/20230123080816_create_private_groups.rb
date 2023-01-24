class CreatePrivateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :private_groups do |t|
      t.string :name
      t.string :detail
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
