# encoding: utf-8
# == Schema Information
# Schema version: 20120804085731
#
# Table name: suppliers
#
#  id                          :integer         not null, primary key
#  first_name                  :string(255)     
#  last_name                   :string(255)     
#  address                     :string(255)     
#  country                     :string(255)     
#  city                        :string(255)     
#  phone_number                :string(255)     
#  user_id                     :integer         
#  created_at                  :datetime        
#  updated_at                  :datetime        
#  email                       :string(255)     default(""), not null
#  encrypted_password          :string(128)     default("")
#  reset_password_token        :string(255)     
#  reset_password_sent_at      :datetime        
#  remember_created_at         :datetime        
#  sign_in_count               :integer         default(0)
#  current_sign_in_at          :datetime        
#  last_sign_in_at             :datetime        
#  current_sign_in_ip          :string(255)     
#  last_sign_in_ip             :string(255)     
#  invitation_token            :string(60)      
#  invitation_sent_at          :datetime        
#  invitation_accepted_at      :datetime        
#  invitation_limit            :integer         
#  invited_by_id               :integer         
#  invited_by_type             :string(255)     
#  supplier_image_file_name    :string(255)     
#  supplier_image_content_type :string(255)     
#  supplier_image_file_size    :integer         
#  supplier_image_updated_at   :datetime        


class Supplier < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable, :invitable

	# attr_accessor :password

	attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :address, :country, :city, :phone_number, :supplier_image
	
	belongs_to :user

	has_many :listings, :dependent => :destroy

	has_many :recommenders

	has_one :account, :dependent => :destroy

	has_one :profile_photo, :dependent => :destroy

	has_attached_file :supplier_image, :styles => { :medium => "300x300>", :small => "150x150>", :thumb => "30x30>" },
					   :default_url => '/images/default.png'

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates	:first_name, :presence =>   	true,
			 			      	:length	 =>   {	:maximum => 50 }
	
	validates	:last_name,  :presence =>   	true,
						       	:length  =>   { :maximum => 50 }

	validate	:password,   :presence => 	true,
				     :confirmation => 	true,
				     :length	=> 	{ :within => 6..40 }

	# validates	:email,	     :presence =>   	true,
	#		       				:format	 =>   {	:with  => email_regex },
	#				       	       	:uniqueness => { :case_sensistive => false }

	validates	:country,    :presence => 	true,
							:length	 =>   { :within => 6..255 }


end
