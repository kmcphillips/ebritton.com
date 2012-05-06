class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.text :body
      t.string :permalink, :null => false, :limit => 61
      t.boolean :imported, :default => false

      t.timestamps
    end

    add_index :posts, :permalink
    add_index :posts, :created_at
  end
end
