class ContactsController < ApplicationController
	before_filter :authenticate, :only => [:new, :create, :destroy]
	before_filter :correct_user, :only => :destroy

	# Need to add a method that stops users from contacting an
	# expired account. Render a polite supplier account expired message
	# to user and send email to supplier about would have been contact
	def new
		@contact = Contact.new
		@title = "Contact supplier"
		@listing = Listing.find_by_id(params["format"])
		@supplier = Supplier.find_by_id(@listing.supplier_id)
	end

	def create
		# Need method to check if user is a recommeded user or not
		@contact = current_user.contacts.build(params[:contact])
		@supplier = Supplier.find_by_email(@contact.email)
		if @supplier.nil?
			flash[:error] = "Supplier doesn't exist"
			redirect_to(:back)
		elsif @contact.save
			@listing = @contact.subject
			Notifier.contact_notifier(@supplier, current_user, @contact, @listing).deliver
			flash[:success] = "Contact added"
			redirect_to(current_user)
		else
			flash[:error] = "Missing subject or message (maximum 255 characters)"
			redirect_to(:back)
		end
	end

	def destroy
		@contact.destroy
		flash[:notice] = "Contact deleted successfully"
		redirect_back_or root_path
	end

	private

	def correct_user
		@contact = Contact.find(params[:id])
		redirect_to(root_path) unless current_user?(@contact.user)
	end

end
