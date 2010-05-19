class TrackerController < ApplicationController

  def dash
    @root_url = "http://localhost:3000"
	  @base_url = "http://www.pivotaltracker.com/services/v3/projects"
  end
  
  def to_xml(move, target)
		builder = Nokogiri::XML::Builder.new do |xml|
	    xml.move {
	      xml.move move
				xml.target target
	    }
    end
	  return builder.to_xml
	end
	
	def connection
  @connection ||= RestClient::Resource.new("https://www.pivotaltracker.com/services/v3", :headers => {'X-TrackerToken' => session[:token], 'Content-Type' => 'application/xml'})
  end
  
  def prioritize
    project  = params[:project]
    story     = params[:story]
    move     = params[:move]
    target   = params[:target]
	  @moved_story = connection["/projects/#{project}/stories/#{story}/moves"].post(self.to_xml(move, target), :content_type => 'application/xml')
  end
  
end
