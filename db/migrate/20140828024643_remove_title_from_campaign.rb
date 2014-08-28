class RemoveTitleFromCampaign < ActiveRecord::Migration
  def change
    remove_column :campaigns, :title
  end
end
