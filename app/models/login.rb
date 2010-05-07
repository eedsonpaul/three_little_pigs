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
	  project_uri = URI.parse("#{@base_url}")
	  project_doc= Login.net_http(project_uri, token, 'projects')
		@project_xmls = []
		@labels = []
		@project_stories = []
		@positions = [[]]
		
		project_count = 0
		
		(project_doc/'project').each do |p|
				@project_xmls << p
				
				project_id = p.at('id').innerHTML
				story_uri = URI.parse("#{@base_url}/#{project_id}/iterations/current")
				story_doc = Login.net_http(story_uri, token, 'stories')
				
				@project_stories << story_doc
				@temp = []
				(story_doc/'story').each do |s|
					if s.innerHTML != nil
					
					  @temp << s.at('id').innerHTML
						if s.at('labels')
						  bool = Login.is_label(s.at('labels').innerHTML)
							@labels <<  s.at('labels').innerHTML if bool == false
						else 
							bool = Login.is_label("Other Activities")
							@labels << "Other Activities" if bool == false
						end
					end
				end
				@positions[project_count] = @temp
				project_count += 1
			end
		@return_val = [@project_xmls,@labels, @project_stories, @positions]
	end
	
	def self.find_labels (xmls, label)
	  ret = []
	  (xmls/'story').each do |s|
	    if s.innerHTML != nil
	      if s.at('labels')
	        ret << s if s.at('labels').innerHTML == label or s.at('story_type').innerHTML == "release"
	      else
	        ret << s if label == "Other Activities" or  s.at('story_type').innerHTML == "release"
	      end
	    end
	  end
	  @return_val = ret
	end
	
end
