class CreateCampaignFeatureJoins < ActiveRecord::Migration
  def change
    create_table :campaign_feature_joins do |t|

    	t.belongs_to :campaign
    	t.belongs_to :feature

      t.timestamps
    end
  end
end
