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
	
	def self.is_label(x)
		@labels.each do |label|
			return true if label==x 
		end
		return false
	end
	
	def self.labelled(token)
	  @base_url = "http://www.pivotaltracker.com/services/v3/projects"
	  i = j = 0
	  project_uri = URI.parse("#{@base_url}")
	  project_doc= Login.net_http(project_uri, token, 'projects')
		@project_xml = []
		@labels = []
		(project_doc/'project').each do |p|
				@project_xml << p
				project_id = p.at('id').innerHTML
				story_uri = URI.parse("#{@base_url}/#{project_id}/stories")
				story_doc = Login.net_http(story_uri, token, 'stories')
				(story_doc/'story').each do |s|
					if s.innerHTML != nil
						if s.at('labels')
							if Login.is_label(s.at('labels').innerHTML) == false
								@labels <<  s.at('labels').innerHTML
							end
						else 
							if Login.is_label("Other Activities") == false
								@labels << "Other Activities"
							end
						end
					end
				end
			end
		@return_val = [@project_xml,@labels]
	end
end
