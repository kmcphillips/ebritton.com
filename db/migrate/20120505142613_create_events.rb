class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :permalink
      t.text :body
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :days
      t.boolean :imported, :default => false

      t.timestamps
    end

    add_index :events, :permalink
    add_index :events, :created_at
    add_index :events, :starts_at
  end
end
