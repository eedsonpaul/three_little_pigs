class TrackerController < ApplicationController

  require 'rubygems'
  require 'hpricot'
  require 'net/http'
  require 'hpricot'
  
  def dash
    @root_url = "http://localhost:3000"

	  @project_xmls = []
	  @project_stories = []
	  @positions = []
	  @labels = []
	  project_count = 0
	  
	  projects = Hpricot((connection["/projects"].get).body).at('projects')
	  (projects/'project').each_with_index do |p, project_count|
	    @project_xmls << p
	    
	    project_id = p.at('id').innerHTML
      stories = Hpricot((connection["/projects/#{project_id}/iterations/current"].get).body).at('stories')
      @project_stories << stories
      temp = []
      
      (stories/'story').each do |s|
        if s.innerHTML != nil
          temp << s.at('id').innerHTML
          if s.at('labels')
            bool = is_label(s.at('labels').innerHTML)
            @labels << s.at('labels').innerHTML if bool == false
          else
            bool = is_label("Other Activities")
            @labels << "Other Activities" if bool == false
          end
        end
      end
      
      @positions[project_count] = temp
    end
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
  
  def connection
    @connection ||= RestClient::Resource.new("https://www.pivotaltracker.com/services/v3", :headers => {'X-TrackerToken' => session[:token], 'Content-Type' => 'application/xml'})
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
    	
  def is_label(x)
	  @labels.each do |label|
		  return true if label==x 
	  end
	  return false
  end

end
