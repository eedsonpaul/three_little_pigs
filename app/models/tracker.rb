class Tracker < ActiveRecord::Base

	def self.find_labels (xmls, label)
	  @unstarted = []
	  @started = []
	  @accepted = []
	  (xmls/'story').each do |s|
	    if s.innerHTML != nil
	      if s.at('labels') != nil
	        if s.at('current_state').innerHTML == 'unstarted'
	          @unstarted << s if s.at('labels').innerHTML == label or s.at('story_type').innerHTML == "release"
	        elsif s.at('current_state').innerHTML == 'accepted'
	          @accepted << s if s.at('labels').innerHTML == label #or s.at('story_type').innerHTML == "release"
	        else
	          @started << s if s.at('labels').innerHTML == label #or s.at('story_type').innerHTML == "release"
	        end
	      else
	        if s.at('current_state').innerHTML == 'unstarted'
	          @unstarted << s if label == "Other Activities" or  s.at('story_type').innerHTML == "release"
	        elsif s.at('current_state').innerHTML == 'accepted'
	          @accepted << s if label == "Other Activities"# or  s.at('story_type').innerHTML == "release"
	        else
	          @started << s if label == "Other Activities" # or  s.at('story_type').innerHTML == "release"
	        end
	      end
	    end
	  end
	  @return_val = [@accepted, @started, @unstarted]
	end
	
end
