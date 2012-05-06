class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url, :null => false
      t.string :title
      t.string :description

      t.timestamps
    end

    add_index :links, :created_at
  end
end
