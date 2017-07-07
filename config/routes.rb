Rails.application.routes.draw do

    # devise_for :users
    devise_for :users, :controllers => { registrations: 'registrations' }

    # == specialty routes
    get "/" => "users#home"
    get "/home" => "users#home"
    get "/stoxx" => "users#stoxx"
    get "/state_mach" => "extras#init"
    get "/update_state/:event" => "extras#update_state"
    get "/new_comment/:post_id" => "comments#new"

    # == json routes
    get "/toggle_tags/:ids" => "users#toggle_tags"
    get "/toggle_state" => "users#toggle_state"
    get "/add_new_tag" => "users#add_new_tag"

    # == RESTful routes
    resources :users do
        resources :posts
        resources :photos
    end
    resources :comments

end
