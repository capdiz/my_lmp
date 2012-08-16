class ListingBatch < ActiveRecord::Base
	attr_accessible :supplier_id, :expires_at, :limit
end
