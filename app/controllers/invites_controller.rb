class InvitesController < ApplicationController

	def new
		@user = User.find(params[:id])
	end

	def create
		render 'users/show'
	end

	def destroy
	end

end
