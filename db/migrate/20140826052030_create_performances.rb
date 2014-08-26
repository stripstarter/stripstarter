class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :user_id
      t.integer :campaign_id

      t.timestamps
    end
  end
end
