require 'spec_helper'

describe Invite do
	before(:each) do
		@attr = {
			@user = Factory(:user)
			@attr = { :content => "value for content" }
		}
	end
	it "should create a new instance given valid attributes" do
		@user.invites.create!(@attr)
	end

	describe "user associations" do
		before(:each) do
			@invite = @user.invites.create(@attr)
		end

		it "should have a user attribute" do
			@invite.should respond_to(:user)
		end

		it "should have the right associated user" do
			@invite.user_id.should == @user.id
			@invite.user.should == @user
		end
	end
	describe "validations" do
		it "should require a user id" do
			Invite.new(@attr).should_not be_valid
		end

		it "should require valid email address" do
			addresses = %w[user@site.com THE_USER@site.bar.org first.last@site.jp]
		       addresses.each do |address|
		       valid_invite_address = Invite.new(@attr.merge(:email => address))
		       valid_invite_address.should be_valid
		       end

		end
		it "should reject invalid email addresses" do
			addresses = %w[user@site,com user_at_site.org exanple.user@site.]
			addresses.each do |address|
				invalid_invite_address = Invite.new(@attr.merge(:email => address))
				invalid_invite_address.should_not be_valid
			end
		end
	end		
end
