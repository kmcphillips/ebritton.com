class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :label, :null => false, :limit => 20
      t.text :body
      t.string :image

      t.timestamps
    end

    add_index :blocks, :label
    add_index :blocks, :image
  end
end
