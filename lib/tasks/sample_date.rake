# require 'faker'

namespace :db do
	desc "Fill category table with our first sample categories"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
	#	make_users
		make_categories
		
	end
end

def make_users
	admin = User.create!(:first_name => "Kuheebwa",
			     :last_name => "Philip",
			     :email => "philo@yahoo.com",
			     :password => "spikee",
			     :password_confirmation => "spikee")
	admin.toggle!(:admin)
	99.times do |n|
		first_name = Faker::Name.first_name
		last_name = Faker::Name.last_name
		email = "philo-#{n+1}@mylmp.co"
		password = "password"
		User.create!(:name => first_name,
			     :last_name => last_name,
			     :email => email,
			     :password => password,
			     :password_confirmation => password)
	end
end

def make_categories
	categories = ["Automobile", "Automobile Accessories", "Computer Accessories", "Bags (Backbacks, handbags and purses)", "Consumer Electronics", "Cosmetics", "Electronics", "Foods & Beverages", "Garments & Textile", "Handmade Crafts and Jewelry", "Heavy Machinery", "Housing & Furniture", "Phone accessories", "Real-estate", "Self Written & Published Books", "Self Written & Produced Music"]
	for cats in categories do
		def_cat = Category.create!(:category_name => cats)
	end
end

