class RecommendationsController < ApplicationController
	before_filter :authenticate, :only => [:new, :create]

	def new
		@recommendation = Recommendation.new
		@title = "Recommendations"
		@listing = Listing.find_by_id(params["format"])
		@supplier = Supplier.find_by_id(@listing.supplier_id)
		@recommendations = Recommendation.find_by_user_id(current_user.id)
	end

	def create
		@recommendation = current_user.recommendations.build(params[:recommendation])
		if @recommendation.save
			@recommended = Supplier.find_by_id(@recommendation.recommended_to_id)
			mail = Notifier.recommendation_notifier(@recommendation, current_user, @recommended)	
			mail.deliver
			flash[:success] = "Your supplier was successfully recommended"
			redirect_to(current_user)
		else
			flash[:notice] = "Invalid email address"
			redirect_to(:back)
		end
	end

	def accept_recommendation
		@recommendation = Recommendation.find_by_recommendation_token(params[:recommendation_token])
		if @recommendation.nil?
			sign_out
			redirect_to(root_path)
			flash[:notice] = "Invalid recommendation token"
		else
			change_token_value
			@user = User.find_by_email(@recommendation.email)
			if @user.nil?
				sign_out
				redirect_to new_user_path(@recommendation)
				flash[:success] = "Recommendation confirmed. Please sign up it's simple and free"
			elsif !@user.nil?
				redirect_to new_user_session_path
				flash[:success] = "Thank you for confirming your recommendation. Please sign in."
			else
				redirect_to(root_path)
				flash[:notice] = "Invalid recommendation token"
			end
		end
	end


	private
	
	def change_token_value
		@recommendation = Recommendation.find(params[:recommendation_id])
		if !@recommendation.recommendation_token.nil?
			@recommendation.update_attributes(:recommendation_accepted_at => Time.now, :recommendation_token => nil)
		end
	end


end

