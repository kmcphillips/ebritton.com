class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.string :permalink, :null => false, :limit => 61
      t.text :body
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :days
      t.boolean :imported, :default => false
      t.string :image

      t.timestamps
    end

    add_index :events, :permalink
    add_index :events, :created_at
    add_index :events, :starts_at
    add_index :events, :image
  end
end
