ActionController::Routing::Routes.draw do |map|
  map.resources 'homepage'
  map.resources 'login'
  map.resources 'users', :member => {:tweet => :get}
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => 'homepage'
  map.home '/home', :controller => 'homepage', :action => 'home'
  map.callback '/callback', :controller => 'login', :action => 'callback' 
  map.logout '/logout', :controller => 'login', :action => 'logout'
  map.dash '/dash', :controller => 'login', :action => 'dash'
  map.pivotal '/pivotal', :controller => 'login', :action => 'pivotal'
  
  map.tweet '/tweet', :controller => 'users', :action => 'tweet'
end
