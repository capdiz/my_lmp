class UserContactsController < ApplicationController
	before_filter :authenticate
	respond_to :html, :js

	def show
		@user_contact = UserContact.find(params[:id])
	end

	def new
		@title = "Add message"
		@user_contact = UserContact.new
	end

	def create
		@user_alerts = UserAlert.paginate(:page => params[:page]).all(:conditions => ["target_location = ?", current_user.city])
		if already_contacted?(params[:user_contact][:contact_id], params[:user_contact][:contact_alert_id])
			flash[:notice] = "User already contacted on said alert"
			respond_with root_path
		else
			@user_contact = current_user.user_contacts.build(params[:user_contact])
			if @user_contact.save
				flash[:succces] = "Message successfully sent"
				respond_with root_path
			else
				render 'new'
			end
		end
	end

	def edit
		@title = "Accept contact"
	end

	def update
		@user_contact = UserContact.find(params[:id])
		if @user_contact.update_attributes(:contact_accepted_at => Time.now, :accepted => true)
			flash[:success] = "Contact Accepted"
			redirect_to(root_path)
		end
	end

	def destroy
		@user_contact = UserContact.find(params[:id])
		@user_contact.destroy
		flash[:notice] = "Contact message successfully deleted"
		redirect_to(:back)
	end

	private
	def already_contacted?(contact_id, contact_alert_id)
		@user_contact = UserContact.find_by_contact_id_and_contact_alert_id(contact_id, contact_alert_id, :conditions => ["user_id = ?", current_user.id])
		return @user_contact unless @user_contact.nil?
	end

	def contact_accepted_at
		
	end
end
