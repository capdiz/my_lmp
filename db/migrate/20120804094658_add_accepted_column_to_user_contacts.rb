class AddAcceptedColumnToUserContacts < ActiveRecord::Migration
  def self.up
	  add_column :user_contacts, :accepted, :boolean, :default => false
  end

  def self.down
	  remove_column :user_contacts, :accepted
  end
end
