class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
	    t.integer 	:user_id
	    t.datetime 	:expires_at
	    t.integer	:listing_limit
	    t.string	:account_type
	    t.float	:account_price 
      t.timestamps
    end
    add_index :accounts, :user_id
  end

  def self.down
    drop_table :accounts
  end
end
