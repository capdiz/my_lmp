class SuppliersController < ApplicationController

	before_filter	:authenticate_supplier, :only => [:index, :edit, :update]
	before_filter	:correct_supplier, :only => [:edit, :update]
	before_filter	:delete_alert

	def new
      		@title = "Supplier sign up"
      		@supplier = Supplier.new
      	end
      
	def show
      		@supplier = Supplier.find(params[:id])
		@listings = @supplier.listings.paginate(:page  => params[:page])
      		@title = @supplier.first_name
      	end
      
	def edit
      		# @supplier = Supplier.find(params[:id])
      		@title = "Edit supplier"
      	end
	
	def update
		# @supplier = Supplier.find(params[:id])
      		if @supplier.update_attributes(params[:supplier])
      			flash[:notice] = "Your profile has been updated."
      			redirect_to @supplier
      		else
      			@title = "Edit supplier"
      			render 'edit'
      		end
       	end	

	def destroy
		Supplier.find(params[:id]).destroy
		flash[:success] = "Supplier deleted."
		redirect_to suppliers_path
	end

	private
		def correct_supplier
			@supplier = Supplier.find(params[:id])
			redirect_to(root_path) unless current_supplier?(@supplier)
		end

		def admin_supplier
			redirect_to(root_path) unless current_supplier.admin?
		end
		
		def delete_alert
	       		if user_signed_in?
				alert = Alert.find_by_supplier_id(params[:id])
				@destroy = alert.destroy if not alert.nil?
			end
		end



end
