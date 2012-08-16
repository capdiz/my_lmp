class ListingsController < ApplicationController
	before_filter :authenticate_supplier, :only => [:destroy, :new]
	before_filter :correct_supplier, :only => [:edit, :update, :destroy]

	respond_to :html, :js

	def new
		@listing = Listing.new
		@categories = Category.find(:all)
		@title = "Supplier listings"
	end
	
	def create
		@account = Account.find_by_supplier_id(current_supplier.id)
		if !@account.nil?
			if @account.account_type == "Pro" && @account.listing_limit < 30 || @account.expires_at < Time.now then
				@listing = current_supplier.listings.build(params[:listing])
				@listing.categories = Category.find(params[:category_ids]) unless params[:category_ids].nil?
       				if @listing.save 
       					flash[:success] = "Listing successfully created"
       					redirect_to supplier_path(current_supplier)
       				else
       					@categories = Category.all
       					respond_with @listing
       				end
			elsif @account.account_type == "Standard" && @ccount.listing_limit < 20 || @account.expires_at < Time.now then
				@listing = current_supplier.listings.build(params[:listing])
       				@listing.categories = Category.find(params[:category_ids]) unless params[:category_ids].nil?
       				if @listing.save 
       					flash[:success] = "Listing successfully created"
       					redirect_to supplier_path(current_supplier)
       				else
       					@categories = Category.all
       					respond_with @listing
       				end
			elsif @account.account_type == "Basic" && @account.listing_limit < 10 || @account.expires_at < Time.now then
				@listing = current_supplier.listings.build(params[:listing])
       				@listing.categories = Category.find(params[:category_ids]) unless params[:category_ids].nil?
       				if @listing.save 
					flash[:success] = "Listing successfully created"
       					redirect_to supplier_path(current_supplier)
       				else
       					@categories = Category.all
       					respond_with @listing
       				end
			else
				if @account.account_type == "Pro" && @account.listing_limit >= 30 then
					flash[:notice] = "Limit over: You can only list up to 30 listings per month"
					redirect_to supplier_path(current_supplier)
				elsif @account.account_type == "Standard" && @account.listing_limit >= 20 then
					flash[:notice] = "Limit over: You can only list up to 20 listings per month"
					redirect_to supplier_path(current_supplier)
				elsif @account.account_type == "Basic" && @account.listing_limit >= 10 then
					flash[:notice] = "Limit over: You can only list up to 10 listings per month"
					redirect_to supplier_path(current_supplier)
				elsif @account.expires_at > Time.now
					flash[:notice] = "Account expired: Please renew your account @ My Account tab"
					redirect_to supplier_path(current_supplier)
				end
			end
		else
			@listing = current_supplier.listings.build(params[:listing])
			@listing.categories = Category.find(params[:category_ids]) unless params[:category_ids].nil?
			if @listing.save 
				flash[:success] = "Listing successfully created"
				redirect_to supplier_path(current_supplier)
			else
				@categories = Category.all
				respond_with @listing
			end
		end
	end

	def edit
		@title = "Edit listing"
	end

	def update
		if @listing.update_attributes(params[:listing])
			flash[:notice] = "Listing successfully updated"
			redirect_to supplier_path(current_supplier)
		else
			@title = "Edit listing"
			render edit
		end
	end

	def destroy
		@listing.destroy
		flash[:notice] = "Listing successfully deleted"
		redirect_to(:back)
	end

	private

	def correct_supplier 
		@listing = Listing.find(params[:id])
		redirect_to(root_path) unless current_supplier?(@listing.supplier)
	end

	#def alert_inviter
	#	@supplier = Supplier.find_by_id(current_supplier.id)
	#	@alert = Alert.create!(:user_id => current_supplier.invited_by_id, :alert_title => @listing.title, :supplier_id => current_supplier.id)
	# if !@user.email.nil?
	#		mail = Notifier.listing_notifier(@user, @supplier, self.title)
	#		mail.deliver
	#	end	
	#end

end
