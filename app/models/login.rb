class Login < ActiveRecord::Base
	
	def self.duplicate(id)
		u = User.find_by_twitter_id(id)
		if u
			return true
		else return false
		end		
	end
	
end
