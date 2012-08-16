class CreateUserAlerts < ActiveRecord::Migration
  def self.up
    create_table :user_alerts do |t|
	    t.string	:title
	    t.integer	:user_id
	    t.string	:target_location
	    t.string	:status
	    t.datetime	:expires_at	 
	    t.string	:prefered_category
      t.timestamps
    end
    add_index :user_alerts, :user_id
  end

  def self.down
    drop_table :user_alerts
  end
end
