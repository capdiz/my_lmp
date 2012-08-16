# Using the symbol ':user' we get Factory girl to simulate the User model.
Factory.define :user do |user|
	user.first_name			"Kusasirwa"
	user.last_name			"Maurice"
	user.email 			"capdiz@example.com"
	user.password			"spikee"
	user.password_confirmation	"spikee"
end

Factory.sequence :email do |n|
	"person-#{n}@example.com"
end

Factory.define :supplier do |supplier|
	supplier.first_name		"Kusasirwa"
	supplier.last_name		"Maurice"
	supplier.email			"capdiz@example.com"
	supplier.password		"spikee"
	supplier.password_confirmation	"spikee"
	supplier.address		"Kampala"
	supplier.country		"Uganda"
	supplier.city			"Kampala"
	supplier.phone_number		"+256-07$2-235125"
end

Factory.define :listing do |listing|
	listing.title		"Listing title"
	listing.description	"Listing description"
	listing.price		"Price"
#	listing.listing_photo   "Listing photo"
	listing.association	:supplier
end

Factory.define :category do |category|
	category.category	"Listing category"
	category.association	:listing
end

# Factory.define :invite do |invite|
#	invite.email "capdiz@site.com"
#	invite.association :user
# end
