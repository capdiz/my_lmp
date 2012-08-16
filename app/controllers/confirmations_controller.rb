class ConfirmationsController < Devise::ConfirmationsController
	def show
		@user = User.find_by_confirmation_token(params[:confirmation_token])
		if !@user.present?
			render_with_scope :new
		end
	end

	def new
	end

	def confirm_account
		@user = User.find_by_confirmation_token(params[:user][:confirmation_token])
		if @user.update_attributes(params[:user]) && @user.password_match?
			@user = User.confirm_by_token(@user.confirmation_token)
			flash[:notice] = "Hi " + @user.first_name + " your email has been verified. You can now start shopping and recommending other users to your supplier networks."
		sign_in_and_redirect("user", @user)
		else
			render :action => 'show'
		end
	end
end
