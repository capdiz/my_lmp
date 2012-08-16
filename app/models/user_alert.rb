# == Schema Information
# Schema version: 20120804085731
#
# Table name: user_alerts
#
#  id                :integer         not null, primary key
#  title             :string(255)     
#  user_id           :integer         
#  target_location   :string(255)     
#  status            :string(255)     
#  expires_at        :datetime        
#  prefered_category :string(255)     
#  created_at        :datetime        
#  updated_at        :datetime        
#

class UserAlert < ActiveRecord::Base
	attr_accessible :title, :target_location, :status, :expires_at
	
	belongs_to :user
	
	has_many :recommenders, :dependent => :destroy

	# has_many :votes
	# has_many :snitches
	# has_many :tellers
	
	validates :title, :presence => true,
			  :length => { :maximum => 50 }

	validates :user_id, :presence => true

	default_scope :order => 'user_alerts.created_at DESC', :limit => 20

	before_save :alert_status, :add_target_location

	private

	def add_target_location
		current_user = User.find_by_id(self.user_id)
		self.target_location = current_user.city
		self.expires_at = 7.days.from_now
	end

	def alert_status
		self.status = "Open"
	end
	
	def expired?
		self.expires_at < 7.days.from_now
	end
		
end
