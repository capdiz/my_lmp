class CreateUserContacts < ActiveRecord::Migration
  def self.up
    create_table :user_contacts do |t|
	    t.integer	:user_id
	    t.integer	:contact_id
	    t.integer	:contact_alert_id
	    t.string	:reply_to_id # Should be an email address to be replied to
	    t.string	:contact_about_alert
	    t.text	:contact_message
	    t.datetime	:contact_created_at
	    t.datetime	:contact_message_sent_at
	    t.datetime	:contact_message_viewed_at

      t.timestamps
    end
    add_index :user_contacts, :user_id
  end

  def self.down
    drop_table :user_contacts
  end
end
