class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :permalink

      t.timestamps
    end

    add_index :posts, :permalink
    add_index :posts, :created_at
  end
end
