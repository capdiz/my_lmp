class Users::RegistrationsController < Devise::RegistrationsController
	def show
		@user = User.find(params[:id])
		@title = @user.first_name
	end
      
	def new
	  @user = User.new
      	end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			render 'confirmations/show'
		else
			render 'pages/home'
		end
	end
	
	# def update
		# check prior comment at the top
	#	@user = User.find(params[:id])
	#	if @user.update_attributes(params[:user])
	#		flash[:notice] = "User profile updated."
	#		redirect_to @user
	#	else
	#		@title = "Edit user"
	#		render 'edit'
	#	end
	# end

	protected

	def after_sign_up_path_for(resource)
		"/users/confirmation?confirmation_token=#{resource.confirmation_token}"
	end

	def after_update_path_for(resource)
		redirect_to user_path(resource)
	end
end
