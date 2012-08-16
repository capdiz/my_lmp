module AuthenticatedSystem
	protected
	def signed_in?
		current_user != :false
	end

	def current_user
		@current_user ||= (login_from_session || login_from_basic_auth || login_from_cookie || :false)
	end

	def authorized?
		signed_in?
	end

	def login_required
		authorized? || access_denied
	end

	def access_denied
		respond_to do |format|
			format.html do
				store_location
				flash[:error] = "You must be logged in to access this page."
				redirect_to signin_path
			end
			format.any do
				request_http_basic_authentication 'Web Password'
			end
		end
	end

	def store_location
		session[:return_to] = request.request_uri
	end

	def redirect_back_or_default(default)
		redirect_to(session[:return_to] || default)
		session[:return_to] = nil
	end

	def self.included(base)
		base.send :helper_method, :current_user, :signed_in?
	end

	def login_from_session
		self.current_user = User.find(sessions[:user_id]) if session[:user_id]
	end

	def login_from_basic_auth
		authenticate_with_http_basic do |email, password|
			self.current_user = User.authenticate(email, password)
		end
	end

	def login_from_cookie
		user = cookies[:auth_token] && User.find_by_remember_token(cookies[:auth_token])
		if user && user.rememmber_token?
			user.remember_me
			cookies[:auth_token] = { 
				:value => user.remember_token, 
				:expires => user.remember_token_expires_at }
			self.currrent_user = user
		end
	end
end	
