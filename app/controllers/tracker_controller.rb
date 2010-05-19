class TrackerController < ApplicationController

  def dash
    @root_url = "http://localhost:3000"
	  @base_url = "http://www.pivotaltracker.com/services/v3/projects"
  end
  
	def connection
  @connection ||= RestClient::Resource.new("https://www.pivotaltracker.com/services/v3", :headers => {'X-TrackerToken' => session[:token], 'Content-Type' => 'application/xml'})
  end
  
  def prioritize
    project = params[:project]
    story = params[:story]
    move = params[:move]
    target = params[:target]
    label = params[:label]
    if (label == "Other Activities")
      updated_label = connection["/projects/#{project}/stories/#{story}?story\[labels\]="].put(self.label_to_xml(" "), :content_type => 'application/xml')
    else
      updated_label = connection["/projects/#{project}/stories/#{story}/"].put(self.label_to_xml(label), :content_type => 'application/xml')
    end
	  moved_story = connection["/projects/#{project}/stories/#{story}/moves"].post(self.prioritize_to_xml(move, target), :content_type => 'application/xml')
  end
  
  def prioritize_to_xml(move, target)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.move {
        xml.move move
		    xml.target target
      }
    end
    return builder.to_xml
  end

  def label_to_xml(label)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.story {
        xml.labels label
      }
    end
    return builder.to_xml
  end

end
