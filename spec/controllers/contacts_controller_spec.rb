require 'spec_helper'

describe ContactsController do
	render_views

	describe "access control" do
		it "should deny access to 'create'" do
			post :create
			response.should redirect_to(new_user_session_path)
		end

		it "should deny access to 'destroy'" do
			post :destroy
			response.should redirect_to(new_user_session_path)
		end
	end

	describe "POST 'create'" do
		before(:each) do
			@user = test_sign_in(Factory(:user))
		end

		describe "failure" do
			before(:each) do
				@attr = { :message => "" }
			end

			it "should not create a contact" do
				lambda do
					post :create, :contact => @attr
				end.should_not change(Contact, :count)
			end

			it "should render the new page" do
				post :create, :contact => @attr		
				response.should render_template('micropost/new')
			end
		end

		describe "success" do
			before(:each) do
				@attr = { :contact => "It ain't hard to tell" }
			end

			it "should create a new contact" do
				lambda do
					post :create, :contact => @attr
				end.should change(Contact, :count).by(1)
			end

			it "should redirect to the home page" do
				post :create, :contact => @attr
				response.should redirect_to(root_path)
			end

			it "should have a flash message" do
				post :create, :micropost => @attr
				flash[:success].should =~ /contact created/i
			end
		end
	end

end
