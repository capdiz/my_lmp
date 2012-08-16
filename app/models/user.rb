# == Schema Information
# Schema version: 20120804085731
#
# Table name: users
#
#  id                      :integer         not null, primary key
#  first_name              :string(255)     
#  last_name               :string(255)     
#  created_at              :datetime        
#  updated_at              :datetime        
#  email                   :string(255)     default(""), not null
#  encrypted_password      :string(128)     default(""), not null
#  reset_password_token    :string(255)     
#  reset_password_sent_at  :datetime        
#  remember_created_at     :datetime        
#  sign_in_count           :integer         default(0)
#  current_sign_in_at      :datetime        
#  last_sign_in_at         :datetime        
#  current_sign_in_ip      :string(255)     
#  last_sign_in_ip         :string(255)     
#  confirmation_token      :string(255)     
#  confirmed_at            :datetime        
#  confirmation_sent_at    :datetime        
#  location                :string(255)     
#  admin                   :boolean         
#  recommended_user        :boolean         
#  user_image_file_name    :string(255)     
#  user_image_content_type :string(255)     
#  user_image_file_size    :integer         
#  user_image_updated_at   :datetime        
#  country                 :string(255)     
#  city                    :string(255)     
#  address                 :string(255)     
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  include DeviseInvitable::Inviter

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # The following code were for my pre-existing user model prior to devise
  # attr_accessor :password

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :confirmation_token, :location, :user_image, :country, :city, :address

  has_many :suppliers
  has_many :invitations, :class_name => 'User', :as => :invited_by 
  has_many :contacts, :dependent => :destroy
  has_many :recommendations, :dependent => :destroy
  has_one  :profile_photo, :dependent => :destroy
  has_many :user_alerts
  has_many :user_contacts, :dependent => :destroy

  has_attached_file :user_image, :styles => { :medium => "300x300>", :small => "150x150>", :thumb => "60x60>" }, :default_url => '/images/default.png'

  # email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :first_name, :presence => true,
			 :length => { :maximum => 50 }
  
  validates :last_name,  :presence => true,
			 :length => { :maximum => 50 }
  
  # validates :email,      :presence => true, 
  #			   :format => { :with => email_regex },
  #		           :uniqueness => { :case_sensitive => false }	
  
  validates :password,   :presence => true,
     			 :confirmation => true,
  			 :length => { :within => 6..40 }

  # before_save :encrypt_password
  def password_match?
    self.errors[:password] << 'password not match' if password != password_confirmation
    self.errors[:password] << 'you must provide a password' if password.blank?
    password == password_confirmation and !password.blank?
  end
  
  
  # This method was used to check submitted user password
  #
  # def has_password?(submitted_password)
	# Compare encrypted_password with the encrypted version of
	# submitted_password.
  #	encrypted_password == encrypt(submitted_password)
  # end
	
  # Method for authenticating user
  #
  # def self.authenticate(email, submitted_password)
  #	user = find_by_email(email)
  #	return nil if user.nil?
  #	return user if user.has_password?(submitted_password)
  # 	user.no_of_logins += 1
  #	user.last_logged_in_at = Time.now
  # 	user.save(:validate => false)
  # end
  
  # method to authenticate user with salt
  #
  # def self.authenticate_with_salt(id, cookie_salt)
  #	user = find_by_id(id)
  #	return nil if user.nil?
  #	return user if user.salt == cookie_salt
  # end
  
  # The following methods were meant for tracking user remember status
  #
  # def remember_token?
  # 	remember_token_expires_at && Time.now.utc < remember_token_expires_at
  # end
  
  # def remember_me
  # 	remember_me_for 2.years
  # end

  # def remember_me_for(time)
  # 	remember_me_until time.from_now.utc
  # end
  
  # def remember_me_until(time)
  # 	self.remember_token_expires_at = time
  #	key = "#{email}--#{remember_token_expires_at}"
  #	self.remember_token = Digest::SHA1.hexdigest(key)
  #	save(:validate => false)
  # end

  # def forget_me
  # 	self.remember_token_expires_at  = nil
  #	self.remember_token		= nil
  #	save(:validate => false)
  # end

  # private
  #
  # These methods were for user password encryption
  #
  # def encrypt_password
  #	self.salt = make_salt if new_record?
  #	self.encrypted_password = encrypt(password)
  # end
  
  # def encrypt(string)
  #	secure_hash("#{salt}--#{string}")
  # end

  # def make_salt
  #	secure_hash("#{Time.now.utc}--#{password}")
  # end

  # def secure_hash(string)
  #	Digest::SHA2.hexdigest(string)
  # end

end
