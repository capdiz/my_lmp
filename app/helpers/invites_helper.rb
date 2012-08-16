module InvitesHelper
	def invite_status(bool)
		if bool == true
			 "Active"
		else
			"Pending"
		end
	end
end
