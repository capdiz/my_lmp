class RecommendersController < ApplicationController
	
	before_filter :authenticate, :only => [:create]
	respond_to :html, :js

	def show
		@recommender = Recommender.new
		@suppliers = Supplier.all(:conditions => ["invited_by_id = ?", current_user.id])
		respond_with root_path
	end

	def new
		@recommender = Recommender.new
		@suppliers = Supplier.all(:conditions => ["invited_by_id = ?", current_user.id])
	end

	def create
		@user_alerts = UserAlert.paginate(:page => params[:page]).all(:conditions => ["target_location = ?", current_user.city])
		@user_alert = UserAlert.find_by_id(params[:user_alert_id])
		if check_exists?(params[:user_alert_id], params[:recommender][:recommended_to_supplier_id])
			update_no_of_recommendations(params[:user_alert_id], params[:recommender][:recommended_to_supplier_id])
		else
			@recommender = @user_alert.recommenders.build(params[:recommender])
			if @recommender.save
				update_no_of_recommendations(params[:user_alert_id], @recommender.recommended_to_supplier_id)
				respond_with root_path
			end
		end
	end

	def edit
		@title = "Block"
		@user_alert = UserAlert.find_by_id(params[:user_alert_id])
	end

	def update
		@recommender = Recommender.find(params[:id])
		if @recommender.update_attributes(:blocked => true)
			respond_with root_path
		end
	end

	def destroy
		@recommender = Recommender.find
	end

	
	private

	def update_no_of_recommendations(user_alert_id, supplier_id)
		@teller = Teller.find_by_user_alert_id_and_supplier_id(user_alert_id, supplier_id)
		if !@teller.nil?
			@teller.update_attributes(:no_of_recommendations => @teller.no_of_recommendations + 1)
		else
			@teller = Teller.create!(:user_alert_id => user_alert_id, :supplier_id => supplier_id, :no_of_recommendations => 1)
		end
	end

	def check_exists?(user_alert_id, recommended_to_supplier_id)
		@recommender = Recommender.find_by_user_alert_id_and_recommended_to_supplier_id(user_alert_id, recommended_to_supplier_id)
		return @recommender unless @recommender.nil?
	end
end
