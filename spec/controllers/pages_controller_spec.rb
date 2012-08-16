require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
	    get 'home'
	    response.should have_selector("title", :content => @base_title + " | Home")
    end
  end

  describe "GET 'pricing'" do
    it "should be successful" do
      get 'pricing'
      response.should be_success
    end
    it "should have the right title" do
	    get 'pricing'
	    response.should have_selector("title", :content => @base_title + " | Pricing")
    end
  end

  decsribe "Get 'about'" do
	  it "should be successful" do
		  get 'about'
		  response.should be_success
	  end
	  it "should have the right title" do
		  get 'about'
		  response.should have_selector("title", :content => @base_title + " | About")
	  end
  end 

end
