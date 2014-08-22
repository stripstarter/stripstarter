class AddNameToCampaign < ActiveRecord::Migration
  def change
  	add_column :campaigns, :name, :text
  end
end
