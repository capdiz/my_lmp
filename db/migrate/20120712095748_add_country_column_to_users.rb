class AddCountryColumnToUsers < ActiveRecord::Migration
  def self.up
	  add_column :users, :country, 	:string
	  add_column :users, :city, 	:string
	  add_column :users, :address, 	:string
  end

  def self.down
	  remove_column :users, :country
	  remove_column :users, :city
	  remove_column :users, :address
  end
end
