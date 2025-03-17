Rails.application.routes.draw do
  get("/", { :controller => "places", :action => "index" })
  resources "entries"
  resources "places"
    resources "users"
  resources "sessions"
  get("/login", {:controller => "sessions", :action => "new"})
  get("/logout", {:controller => "sessions", :action => "destroy"})
  get("/", {:controller => "sessions", :action => "new"})
end
