require 'spec_helper'

describe UsersController do
	render_views
      
	describe "Get 'index'" do
      		describe "for non-signed-in users" do
		  it "should deny access" do
			  get :index
			  response.should redirect_to(new_user_session_path)
			  flash[:notice].should =~ /sign in/i
		  end
		end

		describe "for signed-in users" do
			before(:each) do
				@user  =	test_sign_in(Factory(:user))
				second = 	Factory(:supplier, :email => "another@example.com")
				third  = 	Factory(:supplier, :email => "another@example.net")
				
				@suppliers = (@user, second, third)
			end

			it "should be successful" do
				get :index
				response.should be_success
			end

			it "should have the right title" do
				get :index
				response.should have_selector("title", :content => "Suppliers")
			end

			it "should have an element for each user" do
				get :index
				@suppliers.each do |supplier|
					respond.should have_selector("li", :content => supplier.first_name)
				end
			end
		end

	end
      
	describe "Get 'show'" do
      		before(:each) do
      			@user = Factory(:user)
      		end
      
		it "should be successful" do
      			get :show, :id => @user
      			response.should be_success
      		end

		it "should have the right user" do
      			get :show, :id => @user
      			assigns(:user).should == @user
      		end
      
		it "should have the right title" do
      			get :show, :id => @user
      			response.should have_selector("title", :content => @user.first_name)
      		end
      
		it "should include the user's name" do
      			get :show, :id => @user
      			response.should have_selector("h1", :content => @user.first_name)
      		end

		it "should show the user's suppliers" do
			supplier1 = Factory(:supplier, :user => @user, :first_name => "My Supplier")
			supplier2 = Factory(:supplier, :user => @user, :first_name => "Moi Supplier")
			get :show, :id => @user
			response.should have_selector("span.first_name", :first_name => supplier1.first_name)
			response.should have_selector("span.first_name", :first_name => supplier2.first_name)
		end
	end
      
	describe "GET 'new'" do
	    	it "should be successful" do
		  	get 'new'
		  	response.should be_success
	    	end
	    
		it "should have the right title" do
			get 'new'
	    		response.should have_selector("title", :content => "Sign up")
	    	end
      	end
      
	describe "Post 'create'" do
      		describe "failure" do
      			before(:each) do
      				@attr = { :first_name => "", :last_name => "", :email => "",
    					:password => "", :password_confirmation => "" }
      			end
      
			it "should not create a new user" do
      				lambda do
      					post :create, :user => @attr
      				end.should_not change(User, :count)
      			end
      
			it "should have the right title if 'home' page" do
      				post :create, :user => @attr
      				response.should have_selector("title", :content => "Home")
      			end
      
			it "should have the right titke if 'new' page" do
      				post :create, :user => @attr
      				response.should have_selector("title", :content => "Sign up")
      			end
      
			it "should render the 'home' page" do
      				post :create, :user => @attr
      				response.should render_template('home')
      			end
      
			it "should render the 'new' page" do
      				post :create, :user => @attr
      				response.should render_template('new')
      			end
      		end
      
		describe "success" do
      			before(:each) do
      				@attr = { :first_name => "First Name", :last_name => "Last Name", :email => "user@site.com", :password => "spikee", :password_confirmation => "spikee" }
      			end
      
			it "should create a user" do
      				lambda do
      					post :create, :user => @attr
      				end.should change(User, :count).by(1)
      			end
      
			it "should redirect user to the show page" do 
      				post :create, :user => @attr
      				response.should redirect_to(user_path(assigns(:user)))
      			end

      			it "should have a successful welcome message" do
      				post :create, :user => @attr
      				flash[:success].should =~ /welcome/i
      			end

      			it "should sign in the user" do
      				post :create, :user => @attr
      				contoller.should be_signed_in
      			end
      		end
	end
      	
	describe "GET 'edit'" do
	      	before(:each) do
			@user = Factory(:user)
	      		test_sign_in(@user)
      		end
      
		it "should be successful" do
      			get :edit, :id => @user
      			response.should be_success
      		end
      
		it "should have the right title" do
      			get :edit, :id => @user
      			response.should have_selector("title", :content => "Edit user")
      		end
      	end
      
	describe "PUT 'update'" do
      		before(:each) do
      			@user = Factory(:user)
      			test_sign_in(@user)
      		end
      		describe "failure" do
      			before(:each) do
      				@attr = { :email => "", :name => "", :password => "",
    					  :password_confirmation => ""}
      			end
      
			it "should render the 'edit' page" do
      				put :update, :id => @user, :user => @attr
      				response.should render_template('edit')
      			end
      
			it "should have the right title" do
      				put :update, :id => @user, :user => @attr
      				response.should have_selector("title", :content => "Edit user")
      			end	
      		end
      
		describe "success" do
      			before(:each) do
      				@attr = { :name => "New name", :email => "user@example.org", 
    					:password => "meetoo", :password_confirmation => "meetoo" }
      			end
      
			it "should change the user's attributes" do
      				put :update, :id => @user, :user => @attr
      				@user.reload
      				@user.name.should == @attr[:name]
      				@user.email.should == @ttr[:email]
      			end
      
			it "should redirect to the user show page" do
      				put :update, :id => @user, :user = @attr
      				response.should redirect_to(user_path(@user))
      			end
      
			it "should have a flash message" do
      				put :update, :id => @user, :user => @attr
      				flash[:success].should =~ /updated/
      			end
      		end
      	end
      
	describe "authentication of edit/update pages" do
      		before(:each) do
      			@user = Factory(:user)
      		end
      
		describe "for non-signed-in users" do
      			it "should deny access to 'edit'" do
      				get :edit, :id => @user
      				respond.should redirect_to(signin_path)
      			end
      
			it "should deny access to 'update'" do
      				put :update, :id => @user, :user => {}
      				response.should redirect_to(signin_path)
      			end
      		end
      
		describe "for signed-in users" do
      			before(:each) do
      				wrong_user = Factory(:user, :email => "user@example.net")
      				test_sign_in(wrong_user)
      			end
      
			it "should require matching users for 'edit'" do
      				get :edit, :id => @user
      				response.should redirect_to(root_path)
      			end
      
			it "should require matching users for 'update'" do
      				put :update, :id => @user, :user => {}
      				response.should redirect_to(root_path)
      			end
      		end
	end

	describe "DELETE 'destroy'" do
		before(:each) do
			@user = Factory(:user)
		end

		describe "as a non-signed-in user" do
			it "should protect the page" do
				test_sign_in(@user)
				delete :destroy, :id => @user
				response.should redirect_to(root_path)
			end
		end

		describe "as an admin user" do
			before(:each) do
				admin = Factory(:user, :email => "admin@example.com", :admin => true)
				test_sign_in(admin)
			end

			it "should destroy the user" do
				lambda do
					delete :destroy, :id = @user
				end.should change(User, :count).by(-1)
			end

			it "should redirect to the users page" do
				delete :destroy, :id => @user
				response.should redirect_to(users_path)
			end
		end
	end


end

