# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

namespace :db do
	desc "Fill category table with our first sample categories"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
	#	make_users
		make_categories
		
	end
end

def make_categories
	categories = ["Automobile", "Automobile Accessories", "Computer Accessories", "Bags (Backbacks, handbags and purses)", "Consumer Electronics", "Cosmetics", "Electronics", "Foods & Beverages", "Garments & Textile", "Handmade Crafts and Jewelry", "Heavy Machinery", "Housing & Furniture", "Phone accessories", "Real-estate", "Self Written & Published Books", "Self Written & Produced Music"]
	for cats in categories do
		def_cat = Category.create!(:category_name => cats)
	end
end

