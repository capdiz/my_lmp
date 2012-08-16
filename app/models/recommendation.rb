# == Schema Information
# Schema version: 20120804085731
#
# Table name: recommendations
#
#  id                           :integer         not null, primary key
#  user_id                      :integer         
#  email                        :string(255)     
#  recommended_to_id            :integer         
#  recommended_listing_id       :integer         
#  recommendation_token         :string(255)     
#  recommendation_limit         :integer         
#  recommendation_limit_ends_at :datetime        
#  recommendation_accepted_at   :datetime        
#  recommendation_sent_at       :datetime        
#  created_at                   :datetime        
#  updated_at                   :datetime        
#

class Recommendation < ActiveRecord::Base
	attr_accessible :email, :recommended_to_id, :recommended_listing_id, :recommendation_token, :recommendation_limit, :recommendation_limit_ends_at, :recommendation_accepted_at, :recommendation_sent_at

	belongs_to :user
	belongs_to :listing
       
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	
	validates  :user_id, :presence => true

	
	validates  :email, :presence => true, 
  			   :format => { :with => email_regex }
			   

	before_save :create_recommendation_token
	after_create  :update_limit

	LIMIT_OFFSET = 0
	RECOMMENDATION_LIMIT = 10
	RECOMMENDATION_LIMIT_ENDS_AT = 1.month.from_now

	def create_recommendation_token
		recommender_mail = User.where(:id => self.user_id).select(:email)
		key = "#{self.recommended_to_id}--#{recommender_mail}"
		self.recommendation_token = Digest::SHA1.hexdigest(key) if new_record?
	end
		
	private

	def update_limit
		@recommendation = Recommendation.find_by_user_id(self.user_id)
		if !@recommendation.nil?
			@recommendation.update_attributes(:recommendation_limit => LIMIT_OFFSET + 1, :recommendation_limit_ends_at => RECOMMENDATION_LIMIT_ENDS_AT)
		end
	end
	
	# def recommendation_limit_expired?
	#	self.recommendation_limit_expires_at < Time.now
	# end

	# def limit_ended?
	#	self.recommendation_limit >= RECOMMENDATION_LIMIT
	# end
	#
	# def remove_recommendation_token
	#	self.recommendation_token = nil
	# end

	

end
