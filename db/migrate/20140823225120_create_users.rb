class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :password_confirmation
      t.integer :login_count
      t.string :role

      t.timestamps
    end
  end
end
