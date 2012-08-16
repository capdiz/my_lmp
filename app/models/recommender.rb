# == Schema Information
# Schema version: 20120804085731
#
# Table name: recommenders
#
#  id                         :integer         not null, primary key
#  user_alert_id              :integer         
#  recommended_to_supplier_id :integer         
#  recommended_by_user_id     :integer         
#  recommended_by_name        :string(255)     
#  created_at                 :datetime        
#  updated_at                 :datetime        
#  blocked                    :boolean         
#

class Recommender < ActiveRecord::Base
	
	attr_accessible :recommended_to_supplier_id, :recommended_by_user_id, :recommended_by_name

	validates :user_alert_id, :presence => true

	validates :recommended_to_supplier_id, :presence => true

	belongs_to :user_alert

	belongs_to :supplier

	RECOMMENDATION_OFFSET = 0

	default_scope :order => 'recommenders.created_at DESC', :limit => 4
			
end
