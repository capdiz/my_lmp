class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :user_alert

	include SessionsHelper
	include ListingsHelper

	def after_sign_up_path(resource)
		redirect_to resource
	end

	def after_sign_in_path_for(resource)
		if resource.is_a?(User)
			return resource
		elsif resource.is_a?(Supplier)
			return resource
		else
			super
		end
	end

	def after_update_path_for(resource)
		if resource.is_a?(User)
			user_path(resource)
		elsif resource.is_a?(Supplier)
			supplier_path(resource)
		else
			super
		end
	end

	def after_invite_path_for(resource)
		if resource.is_a?(Supplier)
			user_path(resource)
		else
			super
		end
	end

	def remove_recommendation
		if @recommendation.created_at > 2.days.from_now
			@recommendation.destroy
		end
	end

	protected
	def authenticate_inviter!
		authenticate_user!(:force => true)
	end

	def user_alert
		@user_alert = UserAlert.new
	end

	def expire_user_alerts
		if user_signed_in?
			@user_alert = UserAlert.find_by_user_id(current_user.id)
			if @user_alert.expires_at > Time.now
				@user_alert.update_attributes(:expired => false)
			else
				@user_alert.update_attributes(:expired => true)
			end
		end
	end

end
