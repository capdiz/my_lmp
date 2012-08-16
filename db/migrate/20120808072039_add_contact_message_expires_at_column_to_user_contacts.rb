class AddContactMessageExpiresAtColumnToUserContacts < ActiveRecord::Migration
  def self.up
	  add_column :user_contacts, :contact_message_expires_at, :datetime
  end

  def self.down
	  remove_column :user_contacts, :contact_message_expires_at
  end
end
