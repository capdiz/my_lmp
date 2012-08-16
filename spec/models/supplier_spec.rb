require 'spec_helper'

describe Supplier do
	before(:each) do
		@attr = { :first_name 	=> "First Name",
			  :last_name	=> "Last Name",
			  :email 	=> "supplier@example.com",
	                  :password	=> "spikee",
	                  :password_confirmation => "spikee",
	                  :address	=> "Address",
	                  :country	=> "Country",
	                  :city		=> "City",
			  :phone_number => "Phone number"
		}
	end
	describe "listing associations" do
		before(:each) do
			@supplier = Supplier.create(@attr)
			@listing1 = Factory(:listing, :supplier => @supplier, :created_at => 1.day.ago)
			@listing2 = Factory(:listing, :supplier => @supplier, :created_at => 1.hour.ago)
		end

		it "should have a listings attribute" do
			@supplier.should respond_to(:microposts)
		end

		it "should have the most current listings first" do
			@supplier.listings.should == (@listing2, @listing1)
		end

		it "should destroy associated listings" do
			@supplier.destroy
			[@listing1, @listing2].each do |listing|
				Listing.find_by_id(listing.id).should be_nil
			end
		end

	end

end
