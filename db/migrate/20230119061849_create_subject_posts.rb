class CreateSubjectPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :subject_posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
    add_index :subject_posts, [:user_id, :created_at]
  end
end
