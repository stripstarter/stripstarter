class SetDefaultStatusToActive < ActiveRecord::Migration
  def up
    change_column :campaigns, :status, :string, default: "active"
  end

  def down
    change_column :campaigns, :status, :string, default: "inactive"
  end
end
