class AddProcessingToProfilePhoto < ActiveRecord::Migration
  def self.up
	  add_column :profile_photos, :processing, :boolean
  end

  def self.down
	  remove_column :profile_photos, :processing
  end
end
