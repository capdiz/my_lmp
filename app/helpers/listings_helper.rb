module ListingsHelper
	def expired?
		@batch = ListingBatch.find_by_supplier_id(current_supplier.id)
		@batch.expires_at < Time.now if not @batch.nil? 
	end

	def limit?
		@batch = ListingBatch.find_by_supplier_id(current_supplier.id)
		@batch.limit > 10
	end
end
