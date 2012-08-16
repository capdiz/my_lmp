class AccountsController < ApplicationController
	before_filter :authenticate_supplier, :only => [:edit, :update]
	before_filter :correct_supplier, :only => [:show, :edit, :update]

	def show
		@account = current_supplier.account
		@listings = current_supplier.listings
		user = User.find_by_id(current_supplier.invited_by_id)
		@supplier_user = user if !user.nil?
		recommended_to_emails = Recommendation.all(:conditions => ["recommended_to_id = ?", current_supplier.id], :select => 'email')
		@recommended_users = User.where(:email => recommended_to_emails.map(&:email)) if !recommended_to_emails.nil?
		if @account.account_type == "Pro" && @account.listing_limit <= 30
			@listing_remain = 30 - @account.listing_limit
		elsif @account.account_type == "Standard" && @account.listing_limit <= 20
			@listing_remain = 20 - @account.listing_limit
		elsif @account.account_type == "Basic" && @account.listing_limit <= 10
			@listing_remain = 10 - @account.listing_limit
		end
		# @listing = Listing.find_by_supplier_id(current_supplier.id)
		# @listing_category = ListingCategory.find_by_listing_id(@listing.id) if !@listing.nil?
		# @categories = Category.find(:all, :conditions => @listing_category.category_id)
		# @recommended_users = SharedNetwork.find_by_recommender_id(@user.id)
	end

	def edit
		@title = "Update Account"
		@account = current_supplier.account
	end

	def update
		if @account.expires_at > Time.now 
			flash[:notice] = "Your account is still active"
			redirect_to supplier_path(current_supplier)
		else
			if @account.update_attributes(params[:account])
				reset_limit
				update_price
				flash[:notice] = "Thank you for updating your account"
				redirect_to supplier_path(current_supplier)
			else
				@title = "Update Account"
				render edit
			end
		end
	end

	private

	def correct_supplier
		@account = Account.find_by_supplier_id(current_supplier.id)
		if @account.nil?
			flash[:notice] = "You need to start listing for your account to take effect"
			redirect_to supplier_path(current_supplier)
		else
			@supplier = Supplier.find_by_id(current_supplier.id)
			redirect_to(root_path) unless current_supplier?(@supplier)
		end
	end

	def reset_limit
		if !@account.nil?
			@account.update_attributes(:listing_limit => 0)
		end
	end

	def update_price
		if @account.account_type == "Pro"
			@account.update_attributes(:account_price => 22.99)
		elsif @account.account_type == "Standard"
			@account.update_attributes(:account_price => 14.99)
		elsif @account.account_type == "Basic"
			@account.update_attributes(:account_price => 8.99)
		end
	end

	def listing_categories
	end

end
