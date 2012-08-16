require 'spec_helper'

describe Listing do
      	before(:each) do
      		@supplier = Factory(:supplier)
      		@attr = {	:title => "Listing title",
        		  	:description => "Listing description",
		    	  	:price	=> "Listing price"
		}
	end

	it "should create a new instance givem valid attributes" do
		@supplier.listings.create!(@attr)
	end

	describe "supplier associations" do
		before(:each) do
			@listing = @supplier.listings.create(@attr)
		end

		it "should have a user attribute" do
			@listing.should respond_to(:user)
		end

		it "should have the right associated user" do
			@listing.supplier_id.should == @supplier_id
			@listing.supplier.should == @supplier
		end
	end

	describe "listing validations" do
		it "should require a supplier id" do
			Listing.new(@attr).should_not be_valid
		end

		it "should require a listing title" do
			@supplier.listings.build(:title => " ").should_not be_valid
		end

		it "should reject a long title" do
			@supplier.listings.build(:title => "a" * 51).should_not be_valid
		end

		it "should require a listing description" do
			@supplier.listings.build(:description => " ").should_not be_valid
		end

		it "should reject a long listing description" do
			@supplier.listings.build(:description => "a" * 141).should_not be_valid
		end
	end
		     
end
