class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name

      t.timestamps
    end
  end
end
