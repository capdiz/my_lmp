# == Schema Information
# Schema version: 20120804085731
#
# Table name: listings
#
#  id                         :integer         not null, primary key
#  supplier_id                :integer         
#  title                      :string(255)     
#  description                :string(255)     
#  price                      :float           
#  created_at                 :datetime        
#  updated_at                 :datetime        
#  status                     :string(255)     
#  listing_image_file_name    :string(255)     
#  listing_image_content_type :string(255)     
#  listing_image_file_size    :integer         
#  listing_image_updated_at   :datetime        
#

class Listing < ActiveRecord::Base
	attr_accessible :title, :description, :price, :status, :listing_image, :limit
	
	belongs_to :supplier

	has_many :categories, :through => :listing_categories, :foreign_key => "category_id"

	has_many :listing_categories

	has_many :recommendations

	validates :supplier_id, :presence => true

	validates :title, :presence => true, 
			  :length => { :maximum => 50 }
	
	validates :description, :presence => true, 
				:length => { :maximum => 255 }
	
	validates_numericality_of :price

	has_attached_file :listing_image, :styles => { :medium => "300x300>", :thumb => "100x100>"}, 
									      :storage => :s3,
				    					      :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml" 
	

	LIMIT_OFFSET = 0
	MAX_LISTINGS = 10
	
	# validates :categories, :presence => true

	default_scope :order => 'listings.created_at DESC', :limit => 10

	before_save :change_listing_status

	after_create :alert_inviter, :create_default_account
	
	private

	def change_listing_status
		self.status = "A/V" if status.nil?
	end

	def alert_inviter
		# Send email to supplier inviter after new listing 
		@supplier = Supplier.find_by_id(self.supplier_id)
		@alert = Alert.create!(:user_id => @supplier.invited_by_id, :alert_title => self.title, :supplier_id => self.supplier_id)
		@user = User.find_by_id(@supplier.invited_by_id)
		if !@user.email.nil?
			mail = Notifier.listing_notifier(@user, @supplier, self.title)
			if !new_record?
				mail.deliver
			end
		end
	end
	
	def create_default_account
		@account = Account.find_by_supplier_id(self.supplier_id)
		if !@account.nil?
			@account.update_attributes(:listing_limit => @account.listing_limit + 1)
		else
			@account = Account.create!(:supplier_id => self.supplier_id, :expires_at => 1.month.from_now, :listing_limit => LIMIT_OFFSET + 1, :account_type => "Basic", :account_price => 8.99)
		end
	end

end
