class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.text :body
      t.string :permalink, :null => false, :limit => 61
      t.boolean :imported, :default => false
      t.string :image

      t.timestamps
    end

    add_index :posts, :permalink
    add_index :posts, :created_at
    add_index :posts, :image
  end
end
