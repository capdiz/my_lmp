module AuthenticatedTestHelper
	def login_as(User)
		if user.is_a?(User)
			id = User.id
		elsif user.is_a?(Symbol)
			user = users(user)
			id = user.id
		elsif user.nil?
			id = nil
		end
	end

	def sign_out
		@request.session[:user_id] = nil
		if defined?(controller)
			controller.stub!(:current_user).and_return(:false)
		end
	end

	def authorize_as(user)
		@request.env["HTTP_AUTHORIZATION"] = user ? ActionController::HttpAuthentication::Basic.encode_credentials(users(user).login, 'test') : nil

