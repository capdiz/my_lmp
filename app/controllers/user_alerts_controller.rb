class UserAlertsController < ApplicationController
	before_filter :authenticate, :only => [:index, :destroy]
	before_filter :correct_user, :only => [:edit, :update, :destroy]

	def index
	end

	def show
	end

	def new
	end

	def create
		if !user_signed_in?
			flash[:notice] = "You need to be signed in to create an alert or sign up now. It's free"
			redirect_to new_user_session_path
		elsif current_user.city.nil?
			flash[:notice] = "You need to add your location details to post an alert"
			redirect_to edit_user_path(current_user)
		else
			@user_alert = current_user.user_alerts.build(params[:user_alert])
			if @user_alert.save
				flash[:success] = "Your alert has successfully been posted"
				redirect_to(root_path)
			else
				flash[:notice] = "Empty alert or It's too long"
				redirect_to(root_path)
			end
		end
	end

	def edit
		@title = "Edit" 
	end

	def update
		if @user_alert.update_attributes(params[:user_alert])
			flash[:notice] = "Alert successfully updated"
			redirect_to(root_path)
		else
			@title = "Edit"
			render edit
		end
	end

	def destroy
		@user_alert.destroy
		flash[:notice] = "Alert successfully deleted"
		redirect_to(:back)
	end

	private
	def correct_user
		@user_alert = UserAlert.find(params[:id])
		redirect_to(root_path) unless current_user?(@user_alert.user)
	end
end
