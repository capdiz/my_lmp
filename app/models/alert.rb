# == Schema Information
# Schema version: 20120804085731
#
# Table name: alerts
#
#  id          :integer         not null, primary key
#  user_id     :integer         
#  alert_title :string(255)     
#  created_at  :datetime        
#  updated_at  :datetime        
#  supplier_id :integer         
#

class Alert < ActiveRecord::Base
	attr_accessible :user_id, :alert_title, :supplier_id 
	validates :supplier_id, :presence => true

	default_scope :order => 'alerts.created_at DESC', :limit => 5
end
