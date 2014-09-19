class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|

      t.timestamps

    end

    add_column :photos, :performance_id, :integer
    add_attachment :photos, :image

  end
end
