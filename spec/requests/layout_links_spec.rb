require 'spec_helper'

describe "LayoutLinks" do
	it "should have a Home page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end
	it "should have a Pricing page at '/pricing'" do
		get '/pricing'
		response.should have_selector('title', :content => "Pricing")
	end
	it "should have a Contact page at '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end
	it "should have an About page at '/about'" do
		get '/about'
		response.should have_selector('title', :content => "About")
	end
	it "should have a signin page at '/signin'" do
		get '/signin'
		response.should have_selector('title', :content => "Sign in")
	end
	it "should have a signup page at '/signup'" do
		get '/signup'
		response.should have_selector('title', :content => "Sign up")
	end
	describe "when not signed in" do
		it "should have a signin link path" do
			visit root_path
			response.should have_selector("a", :href => signin_path,
						           :content => "Sign in")
		end
	end
	describe "when user signed in" do
		before(:each) do
			@user = Factory(:user)
			visit signin_path
			fill_in :email, :with => @user.email
			fill_in :password, :with => @user.password
			click_button
		end
		it "should have a signout link" do
			visit root_path
			response.should have_selector("a", :href => signout_path,
						      	   :content => "Sign out")
		end
		it "should have a my networks link" do
			visit root_path
			response.should have_selector("a", :href => "#",
						           :content => "My networks")
		end
		it "should hava an invite link" do
			visit root_path
			response.should have_selector("a", :href => invite_path, 
						      	   :content => "Invite")
		end
		it "should have a profile link" do
			visit root_path
			response.should have_selector("a", :href => user_path(@user),
						      	   :content => "Profile")
	end
end
