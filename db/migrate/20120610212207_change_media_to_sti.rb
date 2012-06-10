class ChangeMediaToSti < ActiveRecord::Migration
  def up
    remove_column :media, :secret
    remove_column :media, :playlist
    add_column :media, :type, :string
    add_index :media, :type
  end

  def down
    remove_column :media, :type
    add_column :media, :secret, :boolean, :default => false
    add_column :media, :playlist, :boolean, :default => false
  end
end
