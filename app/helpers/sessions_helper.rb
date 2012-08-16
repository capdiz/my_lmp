module SessionsHelper
	
	def current_user?(user)
		user == current_user
	end

	def current_supplier?(supplier)
		supplier == current_supplier
	end

	def correct_user?(correct_user)
		correct_user == current_user
	end

	def deny_access
		store_location
		redirect_to new_user_session_path, :notice => "Sign in to access this page."
	end

	def deny_access_supplier
		store_location
		redirect_to new_supplier_session_path, :notice => "Sign in to access this page."
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end

	def authenticate
		deny_access unless user_signed_in?
	end

	def authenticate_supplier
		deny_access_supplier unless supplier_signed_in?
	end

	# commented out session helper methods after adding devise gem
	# to user model

	# def sign_in(user)
	#	cookies.signed[:auth_token] = [user.id, user.salt]		  
	#	current_user = user
	# end

	# def current_user
	#	@current_user ||= user_from_remember_token
	# end

	# def signed_in?
	#	!current_user.nil?
	# end

	# def sign_out
	#	cookies.delete(:auth_token)
	#	current_user = nil
	# end

	private

	def store_location
		session[:return_to] = request.fullpath
	end

	def clear_return_to
		session[:return_to] = nil
	end

	# def user_from_remember_token
	#	User.authenticate_with_salt(*auth_token)
	# end

	# def auth_token
	#	cookies.signed[:auth_token] || [nil, nil]
	# end

	# def login_from_cookie
	#	user = cookies.signed[:remember_token] && User.find_by_remember_token(cookies.signed[:remember_token])
	#	if user && user.remember_token?
	#		user.remember_me
	#		cookies[:remember_token] = {
	#			:value => user.remember_token,
	#			:expires => user.remember_token_expires_at }
	#			current_user = user
	#	end
	# end

end
