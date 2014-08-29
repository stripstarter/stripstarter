class RemoveUserIdFromJoin < ActiveRecord::Migration
  def up
    remove_column :pledges, :user_id
    remove_column :performances, :user_id
  end

  def down
    add_column :pledges, :user_id, :integer
    add_column :performances, :user_id, :integer
  end
end
