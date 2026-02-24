class DropAdmins < ActiveRecord::Migration[6.1]
  def up
    drop_table :admins if table_exists?(:admins)
  end

  def down
  end
end
