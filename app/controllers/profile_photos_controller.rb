class ProfilePhotosController < ApplicationController
	before_filter :correct_profile, :only => [:edit, :update]

	# before_filter :authenticate, :only => [:edit, :update]
	
	# before_filter :correct_supplier, :only => [:edit, :update]

	def new
		@profile_photo = ProfilePhoto.new
	end

	def create
		if supplier_signed_in?
			@profile_photo = current_supplier.build_profile_photo(params[:profile_photo])
			if @profile_photo.save
				flash[:success] = "Your profile photo was successfully added"
				redirect_to supplier_path(current_supplier)
			else
				respond_with @profile_photo
			end
		end
	end

	def edit
		@title = "Change image"
	end

	def update
		if user_signed_in?
			if @profile_photo.update_attributes(params[:profile_photo])
				flash[:notice] = "Your profile picture was successfully updated"
				redirect_to user_path(current_user)
			else
				@title = "Change image" 
				render 'edit'
			end
		elsif supplier_signed_in?
			if @profile_photo.update_attributes(params[:profile_photo])
				flash[:notice] = "Your profile picture was successfully updated"
				redirect_to supplier_path(current_supplier)
			else
				@title = "Change image"
				render 'edit'
			end
		end
	end


	private
	
	def correct_user
		@profile_photo = ProfilePhoto.find_by_user_id(current_user.id)
		redirect_to(root_path) unless current_user?(@profile_photo.user)
	end

	def correct_supplier 
		if supplier_signed_in?
			@profile_photo = ProfilePhoto.find_by_supplier_id(current_supplier.id)
			redirect_to(root_path) unless current_supplier?(@profile_photo.supplier)
		end
	end

	def correct_profile
		if user_signed_in?
			@profile_photo = ProfilePhoto.find_by_user_id(current_user.id)
			redirect_to(root_path) unless current_user?(@profile_photo.user)
		elsif supplier_signed_in?
			@profile_photo = ProfilePhoto.find_by_supplier_id(current_supplier.id)
			redirect_to(root_path) unless current_supplier?(@profile_photo.supplier)
		end
	end
end
