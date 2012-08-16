require 'spec_helper'

describe User do
	before(:each) do
		@attr = { :first_name => "First Name", 
			  :last_name => "Last Name", 
			  :email => "user@example.com",
			  :password => "spikee",
			  :password_confirmation => "spikee"
		}
	end

	it "should create a new instance given valid attributes" do
		User.create!(@attr)
	end
	it "should require the first name" do
		no_first_name_user = User.new(@attr.merge(:first_name => ""))
		no_first_name_user.should_not be_valid
	end
	it "should require the last name" do
		no_last_name_user = User.new(@attr.merge(:last_name => ""))
		no_last_name_user.should_not be_valid
	end
	it "should require an email address" do
		no_email_user = User.new(@attr.merge(:email => ""))
		no_email_user.should_not be_valid
	end
	it "should reject first names that are too long" do
		long_name = "a" * 51
		long_name_user = User.new(@attr.merge(:first_name => long_name))
		long_name_user.should_not be_valid
	end
	it "should reject last names that are too long" do
		long_last_name = "a" * 51
		long_last_name_user = User.new(@attr.merge(:last_name => long_last_name))
		long_last_name_user.should_not be_valid
	end
	it "should reject email addresses that are too long" do
		long_email_address = "a" * 56
		long_email_user = User.new(@attr.merge(:email => long_email_address))
		lon_email_user.should_not be_valid
	end
	it "should accept valid email addresses" do
		addresses = %w[user@site.com THE_USER@site.bar.org first.last@site.jp]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
	end
	it "should reject invalid email addresses" do
		addresses = %w[user@site,com user_at_site.org exanple.user@site.]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address))
			invalid_email_user.should_not be_valid
		end
	end
	it "should reject duplicate email addresses" do
		#put a user with duplicate email address to database
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	it "should reject email addresses identical in casing" do
		uppercased_mail = @attr[:email].upcase
		User.create!(@attr.merge(:email => uppercased_mail))
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	describe "password validations" do
		it "should require a password" do
			User.new(@attr.merge(:password => "", :confirm_password => "")).should_not be_valid
		end
		it "should require a matching password confirmation" do
			User.new(@attr.merge(:confirm_password => "invalid")).should_not be_valid
		end
		it "should reject short passwords" do
			short_pwd = "a" * 5
			hash = @attr.merge(:password => short_pwd, :confirm_password => short_pwd)
			User.new(hash).should_not be_valid
		end
	end
	describe "password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end
		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end
		it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
		end
		describe "has_password? method" do
			it "should be true if passwords match" do
				@user.has_password?(@attr[:password]).should be_true
			end
			it "should be false if the passwords don't match" do
				@user.has_password?("invalid").should be_false
			end
		end

		describe "authenticate method" do
			it "should return nil on email/password mismatch" do
				wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
				wrong_password_user.should be_nil
			end
			it "should return nil for an email address with no user" do
				nonexistent_user = User.authenticate("user@site.com", @attr[:password])
				nonexistent_user.should be_nil
			end
			it "should return user on email/password match" do
				matching_user = User.authenticate(@attr[:email], @attr[:password])
				matching_user.should == @user
			end
			it "should count number of logins" do
				@user.no_of_logins.should change(@user.no_of_logins, :count).by(1)
			end

			it "sets remember token" do
				@user.remember_me
				@user.remember_token.should_not be_nil
				@user.remember_token_expires_at.should_not be_nil
			end
			it "unsets remember token" do
			       @user.remember_me
			       @user.remember_token.should_not be_nil
			       @user.forget_me
			       @user.remember_token.should be_nil
			end
			it "remembers me for one week" do
				before = 1.week.from_now.utc
				@user.remember_me_for 1.week
				after = 1.week.from_now.utc
				@user.remember_token.should_not be_nil
				@user.remember_token_expires_at.should_not be_nil
				@user.remember_token_expires_at.between?(before, after).should be_true
			end
			it "remembers me until one week" do
				time = 1.week.from_now.utc
				@user.remember_me_until time
				@user.remember_token.should_not be_nil
				@user.remember_token_expires_at.should_not be_nil
				@user.remember_token_expires_at.should == time
			end
			it "remembers me default two weeks" do
				before = 2.weeks.from_now.utc
				@user.remember_me
				after.2.weeks.from_now.utc
				@user.remember_token.should_not be_nil
				@user.remember_token_expires_at.should_not be_nil
				@user.remember_token_expires_at.between?(before, after).should be_true
			end
			

		end
	end

	describe "invites associations" do
		before(:each) do
			@user = User.create(@attr)
		end
		it "should have an invite attribute" do
			@user.should respond_to(:invites)
		end
	end

	describe "admin attribute" do
		before(:each) do
			@user = User.create!(@attr)
		end

		it "should respond to admin" do
			@user.should respond_to(:admin)
		end

		it "should not be an admin by default" do
			@user.should_not be_admin
		end

		it "should be convertible to an admin" do
			@user.toggle!(:admin)
			@user.should be_admin
		end
	end

end
