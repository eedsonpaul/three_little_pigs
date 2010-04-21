ActionController::Routing::Routes.draw do |map|
  map.resources 'homepage'
  map.resources 'login'
  map.resources 'users'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => 'homepage'
  map.callback '/callback', :controller => 'login', :action => 'callback'
end
