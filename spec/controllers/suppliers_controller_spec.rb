require 'spec_helper'

describe SuppliersController do
	render_views
	describe "Get 'index'" do
		describe "for non-signed-in suppliers" do
			it "should deny access" do
				get :index
				response.should redirect_to(new_supplier_session_path)
				flash[:notice].should =~ /sign in/i
			end
		end

		describe "for signed-in suppliers" do
			before(:each) do
				@supplier = test_sign_in(Factory(:supplier))
				second 	  = Factory(:supplier, :email => "another@example.com")
				third	  = Factory(:supplier, :email => "another@example.com")
				@users 	  = (@user, second, third)
			end

			it "should be successful" do
				get :index
				response.should be_success
			end

			it "should have the right title" do
				get :index
				response.should have_selector("title", :content => "Suppliers")
			end

			it "should have an element for each supplier" do
				get :index
				@suppliers.each do |supplier|		
					respond.should have_selector("li", :content => supplier.first_name)
				end
			end
		end
	end
				
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

end
