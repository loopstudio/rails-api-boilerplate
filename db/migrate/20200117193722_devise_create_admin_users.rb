class DeviseCreateAdminUsers < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    create_table :admin_users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps null: false
    end

    add_index :admin_users, :email,                unique: true, algorithm: :concurrently
    add_index :admin_users, :reset_password_token, unique: true, algorithm: :concurrently
  end
end
