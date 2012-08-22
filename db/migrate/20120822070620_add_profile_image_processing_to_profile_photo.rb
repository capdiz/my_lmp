class AddProfileImageProcessingToProfilePhoto < ActiveRecord::Migration
  def self.up
	  add_column :profile_photos, :profile_image_processing, :boolean
  end

  def self.down
	  remove_column :profile_photos, :profile_image_processing
  end  
end
