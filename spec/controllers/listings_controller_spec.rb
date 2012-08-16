require 'spec_helper'

describe ListingsController do
	render_views

	describe "access control" do
		it "should deny access to 'create'" do
			post :create
			response.should redirect_to(new_supplier_session_path)
		end

		it "should deny access to 'destroy'" do
			delete :destroy, :id => 1
			response.should redirect_to(new_supplier_session_path)
		end
	end

	describe "POST 'create'" do
		before(:each) do
			@supplier = test_sign_in(Factory(:supplier))
		end

		describe "failure" do
			before(:each) do
				@attr = { :title => "",
					  :description => "",
					  :price => "" }
			end

			it "should not create a new listing" do
				lambda do
					post :create, @listing => @attr
				end.should_not change(Listing, :count)
			end
		end

		describe "success" do
			before(:each) do
			       @attr = { :title => "listing title",
			       		 :description => "description",
			  		 :price => "listing price" }
			end

			it "should create a listing" do
				lambda do
					post :create, :listing => @attr
				end.should change(Listing, :count).by(1)
			end
		end
	end 			


end
