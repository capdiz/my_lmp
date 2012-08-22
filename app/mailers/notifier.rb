class Notifier < ActionMailer::Base

  default :from => "no-reply@my_lmp.us",
  	  :return_path => "info@mylmp.us"

  # The new listing notifier should be sent to 
  # both a suppliers' inviter and a shared network.
  def listing_notifier(user, supplier, listing)
	  @user = user
	  @supplier = supplier
	  @listing = listing
	  @login_url = "http://www.mylmp.herokuapp.com/signin"
	  mail(:to => user.email,
	       :subject => "#{supplier.first_name} just listed a new #{listing}")
  end

  # Contact notifier will let users send an email to suppliers
  # incase they happen to have interest in a listing
  def contact_notifier(supplier, user, contact, listing)
	  @supplier = supplier
	  @user = user
	  @contact = contact
	  @listing = listing
	  mail(:to => supplier.email,
	       :subject => "#{user.first_name} posted an inquiry on #{listing}")
  end

  # Recommendation notifier will let users send out an email 
  # recommending their own suppliers to other users incase a 
  # product alert has been posted by another user.  
  def recommendation_notifier(recommended_user, recommender, recommended)
	@recommendation = recommended_user
	@recommender = recommender
	@recommended = recommended
	mail(:to => recommended_user.email,
	     :subject => "#{recommender.first_name} just recommended you to their supplier #{recommended.first_name} on mylmp.com")
  end

  # Report notifier lets site admin look into report cases 
  # against supplier 
  def report_notifier(supplier)
	  @supplier = supplier
	  mail(:to => supplier.email,
	       :subject => "#{supplier.first_name} you just recieved a report on your local market-place")
  end

  # Method will check if an account has expired and 
  # send an email to supplier about account expired notification
  def account_expired_notifier
  end

end
