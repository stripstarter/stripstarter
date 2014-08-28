class AddAmountToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :amount, :money, default: 0 
  end
end
