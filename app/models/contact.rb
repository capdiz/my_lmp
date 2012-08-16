# == Schema Information
# Schema version: 20120804085731
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  message    :string(255)     
#  user_id    :integer         
#  email      :string(255)     
#  created_at :datetime        
#  updated_at :datetime        
#  subject    :string(255)     
#

class Contact < ActiveRecord::Base
	attr_accessible :message, :email, :subject
	
	belongs_to :user
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	
	validates :message, :presence => true, :length => { :maximum => 255 }
	validates :subject,   :presence => true, :length => { :maximum => 50 }
	validates :user_id, :presence => true

	validates :email,      :presence => true, 
		  :format => { :with => email_regex }

	default_scope :order => 'contacts.created_at DESC'

end
