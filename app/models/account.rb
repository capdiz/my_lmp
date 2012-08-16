# == Schema Information
# Schema version: 20120804085731
#
# Table name: accounts
#
#  id            :integer         not null, primary key
#  supplier_id   :integer         
#  expires_at    :datetime        
#  listing_limit :integer         
#  account_type  :string(255)     
#  account_price :float           
#  created_at    :datetime        
#  updated_at    :datetime        
#

class Account < ActiveRecord::Base
	attr_accessible :supplier_id, :expires_at, :listing_limit, :account_type, :account_price

	belongs_to :supplier
	validates :supplier_id, :presence => true
end
