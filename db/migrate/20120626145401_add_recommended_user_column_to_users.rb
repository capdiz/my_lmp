class AddRecommendedUserColumnToUsers < ActiveRecord::Migration
  def self.up
	  add_column :users, :recommended_user, :boolean, :default => false
  end

  def self.down
	  remove_column :users, :recommended_user
  end
end
