class AddAuthlogicDependenciesToUser < ActiveRecord::Migration
  def change
    remove_column :users, :password
    remove_column :users, :password_confirmation

    add_column :users, :crypted_password, :string
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string

    add_column :users, :failed_login_count, :integer, null: false, default: 0
    add_column :users, :last_request_at, :datetime
    add_column :users, :current_login_at, :datetime
    add_column :users, :last_login_at, :datetime
    add_column :users, :current_login_ip, :string
    add_column :users, :last_login_ip, :string
  end
end
