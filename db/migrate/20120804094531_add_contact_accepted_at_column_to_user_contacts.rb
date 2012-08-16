class AddContactAcceptedAtColumnToUserContacts < ActiveRecord::Migration
  def self.up
	  add_column :user_contacts, :contact_accepted_at, :datetime
  end

  def self.down
	  remove_column :user_contacts, :contact_accepted_at
  end
end
