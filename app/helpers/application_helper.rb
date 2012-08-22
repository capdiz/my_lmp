module ApplicationHelper
	def title
		base_title = "An invite only market-place"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end

	def resource_name
		:user || :supplier
	end

	def resource
		@resource ||= User.new || Supplier.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user || :supplier]
	end
end
