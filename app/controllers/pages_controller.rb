class PagesController < ApplicationController
  def home
	  @title = "Home"
	  @recommender = Recommender.new
	  @user = User.new
	  if user_signed_in?
		  # @suppliers = Supplier.paginate(:page => params[:page]).all(:conditions => ["invited_by_id = ?", current_user.id])
		  @alerts = Alert.all(:conditions => ["user_id = ?", current_user.id])
		  @user_alerts = UserAlert.paginate(:page => params[:page]).all(:conditions => ["target_location = ?", current_user.city])
		  @user_contacts = UserContact.all(:conditions => ["contact_id = ?", current_user.id])
		  user_alert_ids = UserAlert.all(:conditions => ["user_id = ?", current_user.id], :select => 'id')
		  @recommended_supplier_alerts = Recommender.where(:user_alert_id => user_alert_ids.map(&:id))
		  @no_of_recommendations = Teller.where(:user_alert_id => user_alert_ids.map(&:id)).select(:no_of_recommendations)
		  if !current_user.recommended_user?
			  recommended_to_ids = Recommendation.all(:conditions => ["email = ?", current_user.email], :select => 'recommended_to_id')
			  @recommended_suppliers = Supplier.where(:id => recommended_to_ids.map(&:recommended_to_id)).paginate(:page => params[:page])
			  @recommended_alerts = Alert.where(:supplier_id => recommended_to_ids.map(&:recommended_to_id))
		  end
	  else		  
		  flash[:notice] = "Please sign in or create an account."
		  redirect_to(root_path)
	  end
  end

  def pricing
	  @title = "Pricing"
  end

  def about
	  @title = "About"
  end

  def contact
	  @title = "Contact"
  end
end
