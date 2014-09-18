class AddOwnerIdToCampaign < ActiveRecord::Migration
  def up
    add_column :campaigns, :owner_id, :integer, default: nil
  end

  def down
    remove_column :campaigns, :owner_id
  end
end
