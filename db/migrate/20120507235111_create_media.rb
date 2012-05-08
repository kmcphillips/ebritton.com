class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :name
      t.text :description
      t.string :file
      t.boolean :secret, :default => false
      t.boolean :playlist, :default => false

      t.timestamps
    end

    add_index :media, :file
  end
end
