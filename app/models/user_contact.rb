# == Schema Information
# Schema version: 20120804085731
#
# Table name: user_contacts
#
#  id                        :integer         not null, primary key
#  user_id                   :integer         current user
#  contact_id                :integer         person who posted alert
#  contact_alert_id          :integer         user_alert_id
#  reply_to_id               :string(255)     an email address for current user
#  contact_about_alert       :string(255)     
#  contact_message           :text            
#  contact_created_at        :datetime        
#  contact_message_sent_at   :datetime        
#  contact_message_viewed_at :datetime        
#  created_at                :datetime        
#  updated_at                :datetime        
#  blocked                   :boolean         
#

class UserContact < ActiveRecord::Base
	attr_accessible :contact_id, :contact_alert_id, :reply_to_id, :contact_about_alert, :contact_message, :contact_created_at, :contact_message_sent_at, :contact_message_viewed_at, :blocked, :contact_accepted_at, :accepted

	belongs_to :user

	validates :user_id, :contact_id, :contact_alert_id, :presence => true

	validates :contact_message, :presence => true, :length => { :maximum => 140 }

	validates :contact_about_alert, :presence => true, :length => { :maximum => 255 }

	default_scope :order => 'user_contacts.created_at DESC', :limit => 4

	before_save :add_message_details

	private

	def add_message_details
		self.contact_created_at = Time.now
		self.contact_message_sent_at = Time.now
		self.contact_message_expires_at = 7.days.from_now
	end

end
