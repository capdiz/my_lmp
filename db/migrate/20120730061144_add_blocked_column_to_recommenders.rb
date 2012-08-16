class AddBlockedColumnToRecommenders < ActiveRecord::Migration
  def self.up
	  add_column :recommenders, :blocked, :boolean, :default => false
  end

  def self.down
	  remove_column :recommenders, :blocked
  end
end
