class AddDeviseToSuppliers < ActiveRecord::Migration
  def self.up
	  change_table(:suppliers) do |t|
		  t.database_authenticatable :null => false
		  t.recoverable
		  t.rememberable
		  t.trackable
		 
		  #  t.confirmable

		  # t.encryptable
		  # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => both
		  # t.token_authenticable
	  end
	  add_index :suppliers, :email,			:unique => true
	  add_index :suppliers, :reset_password_token,	:unique => true
	  # add_index :suppliers, :confirmation_token,	:unique => true
  end

  def self.down
	  change_table :suppliers do |t|
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
     		  # t.remove :confirmation_token
     		  # t.remove :confirmed_at
     		  # t.remove :confirmation_sent_at
	  end
  end
end
