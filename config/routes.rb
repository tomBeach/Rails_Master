Rails.application.routes.draw do

    # devise_for :users
    devise_for :users, :controllers => { registrations: 'registrations' }

    get "/" => "users#home"
    get "/home" => "users#home"
    get "/toggle_tag" => "users#toggle_tag"

    resources :users do
        resources :posts
        resources :photos
    end
    resources :comments

end
