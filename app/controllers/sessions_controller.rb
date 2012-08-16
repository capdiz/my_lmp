class SessionsController < ApplicationController

  def new
	  @title = "Sign in"
  end

  def create
	  user = User.authenticate(params[:session][:email], params[:session][:password])
	  if user.nil?
		  flash.now[:error] = "Invalid email or password."
		  @title = "Sign up"
		  render 'new'
	  else
		  sign_in user
		  if params[:remember_ne] == "1"
			  current_user.remember_me
		  end
		  redirect_back_or user
	  end
  end

  def destroy
	  sign_out
	  redirect_to root_path
  end

 
end

