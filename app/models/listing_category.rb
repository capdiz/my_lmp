# == Schema Information
# Schema version: 20120804085731
#
# Table name: listing_categories
#
#  listing_id  :integer         
#  category_id :integer         
#  created_at  :datetime        
#  updated_at  :datetime        
#

class ListingCategory < ActiveRecord::Base
	attr_accessible :listing_id, :category_id

	belongs_to :listing
	belongs_to :category

	validates :listing_id, :presence => true
	validates :category_id, :presence => true

end
