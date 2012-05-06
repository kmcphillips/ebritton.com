class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :type
      t.string :title, :null => false
      t.text :body
      t.datetime :happened_at
      t.boolean :imported, :default => false
      t.string :imported_image

      t.timestamps
    end

    add_index :projects, :type
    add_index :projects, :imported
    add_index :projects, :created_at
  end
end
