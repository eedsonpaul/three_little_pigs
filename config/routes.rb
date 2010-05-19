ActionController::Routing::Routes.draw do |map|
  map.resources 'homepage'
  map.resources 'login'
  map.resources 'tracker'
  map.resources 'twitter', :member => {:tweet => :get}
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.root :controller => 'homepage'
  map.twitter '/create', :controller => 'twitter', :action => 'create'
  map.home '/home', :controller => 'homepage', :action => 'home'
  map.callback '/callback', :controller => 'login', :action => 'callback' 
  map.logout '/logout', :controller => 'login', :action => 'logout'
  map.dash '/dash', :controller => 'tracker', :action => 'dash'
  map.pivotal '/pivotal', :controller => 'login', :action => 'pivotal'
  map.tweet '/tweet', :controller => 'twitter', :action => 'tweet'
  map.prioritize '/story', :controller => 'tracker', :action => 'prioritize'
  map.label '/story', :controller => 'tracker', :action => 'update_label'
  
end
