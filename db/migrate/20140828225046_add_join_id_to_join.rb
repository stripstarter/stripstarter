class AddJoinIdToJoin < ActiveRecord::Migration
  def change
    add_column :pledges, :pledger_id, :integer
    add_column :performances, :performer_id, :integer
  end
end
