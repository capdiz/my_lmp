# == Schema Information
# Schema version: 20120804085731
#
# Table name: tellers
#
#  id                    :integer         not null, primary key
#  user_alert_id         :integer         
#  supplier_id           :integer         
#  no_of_recommendations :integer         
#  created_at            :datetime        
#  updated_at            :datetime        
#

class Teller < ActiveRecord::Base
	attr_accessible :user_alert_id, :supplier_id, :no_of_recommendations

	validates :user_alert_id, :presence => true

	validates :supplier_id, :presence => true

end
