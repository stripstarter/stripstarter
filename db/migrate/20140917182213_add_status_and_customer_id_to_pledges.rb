class AddStatusAndCustomerIdToPledges < ActiveRecord::Migration
  def up
    add_column :pledges, :status, :string
    add_column :users, :stripe_customer_id, :string
  end

  def down
    remove_column :pledges, :status
    remove_column :users, :stripe_customer_id
  end
end
