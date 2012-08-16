# == Schema Information
# Schema version: 20120804085731
#
# Table name: categories
#
#  id            :integer         not null, primary key
#  category_name :string(255)     
#  created_at    :datetime        
#  updated_at    :datetime        
#

class Category < ActiveRecord::Base
	belongs_to :listing
end
