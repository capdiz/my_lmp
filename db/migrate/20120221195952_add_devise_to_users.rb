class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable

      # t.encryptable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
     change_table :users do |t|
	     t.remove :email
	     t.remove :encrypted_password
	     t.remove :reset_password_token
	     t.remove :reset_password_sent_at
	     t.remove :remember_created_at
	     t.remove :sign_in_count
	     t.remove :current_sign_in_at
	     t.remove :last_sign_in_at
	     t.remove :current_sign_in_ip
	     t.remove :last_sign_in_ip
	     t.remove :confirmation_token
	     t.remove :confirmed_at
	     t.remove :confirmation_sent_at
     end
	    	  
  end
end
