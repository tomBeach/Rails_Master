Rails.application.routes.draw do

    resources :users do
        resources :posts
    end
    resources :comments

    get "/" => "users#home"
    get "/home" => "users#home"
    get "/signin" => "users#signin"
    get "/signout" => "users#signout"

end
