class Tracker < ActiveRecord::Base

	def self.find_labels (xmls, label)
	  ret = []
	  (xmls/'story').each do |s|
	    if s.innerHTML != nil
	      if s.at('labels') != nil
	        ret << s if s.at('labels').innerHTML == label or s.at('story_type').innerHTML == "release"
	      else
	        ret << s if label == "Other Activities" or  s.at('story_type').innerHTML == "release"
	      end
	    end
	  end
	  @return_val = ret
	end
	
end
