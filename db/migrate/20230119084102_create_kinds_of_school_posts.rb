class CreateKindsOfSchoolPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :kinds_of_school_posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :kinds_of_school, null: false, foreign_key: true

      t.timestamps
    end
    add_index :kinds_of_school_posts, [:user_id, :created_at]
  end
end
