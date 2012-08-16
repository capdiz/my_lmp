class AddUserLocationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :location, :string, :default => nil
  end

  def self.down
    remove_column :users, :location
  end
end
