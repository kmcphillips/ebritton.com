class RemoveStiOnProject < ActiveRecord::Migration
  def up
    remove_column :projects, :type
    add_column :projects, :written, :boolean, :default => false
    add_index :projects, :written
  end

  def down
    remove_column :projects, :written
    add_column :projects, :type, :string
    add_index :projects, :type
  end
end
