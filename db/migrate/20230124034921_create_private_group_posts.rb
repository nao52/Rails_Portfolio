class CreatePrivateGroupPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :private_group_posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :private_group, null: false, foreign_key: true

      t.timestamps
    end
    add_index :private_group_posts, [:user_id, :created_at]
  end
end
