class Suppliers::RegistrationsController < Devise::RegistrationsController

	def show
		@supplier = Supplier.find(parans[:id])
		@title = Supplier.first_name
	end

	def new
		@supplier = Supplier.new(params[:supplier])
	end

	protected
	def after_update_path_for(resource)
		if resource.is_a(Supplier)
			supplier_path(resource)
		else
			super
		end
	end

end
