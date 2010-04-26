class Login < ActiveRecord::Base

  def self.duplicate(id)
	  u = User.find_by_twitter_id(id)
	  bool = (u) ? true : false
	  return bool
  end
  
  def self.duplicate_token(token)
  	u = User.find_by_token(token)
  	bool = (u) ? true : false
	  return bool
  end	
  
	def self.net_http(uri, token, tag)
		response = Net::HTTP.start(uri.host, uri.port) do |http|
			http.get(uri.path, {'X-TrackerToken' => token})
		end
		doc = Hpricot(response.body).at(tag)
		return doc
	end

end
