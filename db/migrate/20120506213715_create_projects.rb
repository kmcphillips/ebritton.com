class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :type
      t.string :title, :null => false
      t.string :permalink, :null => false, :limit => 61
      t.text :body
      t.datetime :happened_at
      t.boolean :imported, :default => false
      t.string :image
      t.integer :media_id

      t.timestamps
    end

    add_index :projects, :type
    add_index :projects, :imported
    add_index :projects, :created_at
    add_index :projects, :image
    add_index :projects, :media_id
  end
end
