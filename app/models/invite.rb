# == Schema Information
# Schema version: 20120328133743
#
# Table name: invites
#
#  id         :integer         not null, primary key
#  email      :string(255)     
#  user_id    :integer         
#  created_at :datetime        
#  updated_at :datetime        
#

class Invite < ActiveRecord::Base
	attr_accessible :email
	belongs_to :user
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, :presence => true,
		  :format => { :with => email_regex }


	validates :user_id, :presence => true

end
