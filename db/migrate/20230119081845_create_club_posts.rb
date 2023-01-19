class CreateClubPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :club_posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :club, null: false, foreign_key: true

      t.timestamps
    end
    add_index :club_posts, [:user_id, :created_at]
  end
end
