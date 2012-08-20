# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MyLmp::Application.initialize!

  ActionMailer::Base.smtp_settings = { 
	:address =>	"smtp.mandrillapp.com",
	:port =>	587,
	:user_name =>	ENV["capdiz@yahoo.com"],
	:password =>	ENV["70df126e-e283-4a10-939c-75b3130376ef"],
	:domain => "www.mylmp.us"
  }	
