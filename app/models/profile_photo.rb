# == Schema Information
# Schema version: 20120804085731
#
# Table name: profile_photos
#
#  id                         :integer         not null, primary key
#  user_id                    :integer         
#  supplier_id                :integer         
#  created_at                 :datetime        
#  updated_at                 :datetime        
#  profile_image_file_name    :string(255)     
#  profile_image_content_type :string(255)     
#  profile_image_file_size    :integer         
#  profile_image_updated_at   :datetime        
#

class ProfilePhoto < ActiveRecord::Base

	attr_accessible :user_id, :supplier_id, :profile_image

	belongs_to :user
	
	belongs_to :supplier

	has_attached_file :profile_image, :styles => { :medium => "300x300>", :small => "150x150>", :thumb => "60x60>" }, :default_url => '/images/default.png',
					  :storage => :s3,
					  :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml"
					  

	validates_attachment_size :profile_image, :less_than => 3.megabytes

end
