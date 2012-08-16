class UsersController < ApplicationController
	before_filter :authenticate,  :only =>  [:index]
	before_filter :correct_user,  :only =>  [:edit, :update]
	before_filter :correct_email, :only =>  [:new]

	def index
		@title = "Suppliers"
		@users = User.all if current_user.admin?
	end

	def show
		@user = User.find(params[:id])
		if user_signed_in?
			if correct_user?(@user)
				@suppliers = Supplier.paginate(:page => params[:page]).all(:conditions => ["invited_by_id = ?", current_user.id])
				@alerts = Alert.all(:conditions => ["user_id = ?", current_user.id])
				if !current_user.recommended_user?
					recommended_to_ids = Recommendation.all(:conditions => ["email = ?", @user.email], :select => 'recommended_to_id')
					@recommended_suppliers = Supplier.where(:id => recommended_to_ids.map(&:recommended_to_id)).paginate(:page => params[:page])
					@recommended_alerts = Alert.where(:supplier_id => recommended_to_ids.map(&:recommended_to_id))		
				end
			else
				@suppliers = Supplier.paginate(:page => params[:page]).all(:conditions => ["invited_by_id = ?", current_user.id])
				@alerts = Alert.all(:conditions => ["user_id = ?", current_user.id])
				if !current_user.recommended_user?
					recommended_to_ids = Recommendation.all(:conditions => ["email = ?", @user.email], :select => 'recommended_to_id')
					@recommended_suppliers = Supplier.where(:id => recommended_to_ids.map(&:recommended_to_id)).paginate(:page => params[:page])
					@recommended_alerts = Alert.where(:supplier_id => recommended_to_ids.map(&:recommended_to_id))		
				end
			end
		elsif supplier_signed_in?
			@suppliers = Supplier.all(:conditions => ["invited_by_id = ?", @user.id])
			if !@user.recommended_user?
				recommended_to_ids = Recommendation.all(:conditions => ["email = ?", @user.email], :select => 'recommended_to_id')
				@recommended_suppliers = Supplier.where(:id => recommended_to_ids.map(&:recommended_to_id)).paginate(:page => params[:page])
			end
		else
			flash[:notice] = "Please sign in or create an account."
			redirect_to(root_path)
		end
		@title = @user.first_name
	end
      
	def new
	  @user = User.new
      	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Hi " + @user.first_name + ", welcome to your local market-place."
			redirect_to @user
		else
			render 'pages/home'
		end
	end

	def edit
		# commented it out because correct_user method defines current_user
		# @user = User.find(params[:id])
		@title = "Edit user"
	end

	def update
		# check prior comment at the top
	 	# @user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:notice] = "Your profile has been updated. Please sign in again with your new settings"
			redirect_to(root_path)
		else
			@title = "Edit user"
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to users_path
	end

	private
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def correct_email
			@recommendation = Recommendation.find(params["format"]) if @recommendation.nil?
		end
end
