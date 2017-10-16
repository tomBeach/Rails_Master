class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_filter :configure_permitted_parameters, if: :devise_controller?
    before_filter :authenticate_user!, except: [:login]
    before_filter :set_cache_headers

    private
        def set_cache_headers
            puts "******* set_cache_headers *******"
            response.headers["Cache-Control"] = "no-cache, no-store"
        end

    protected
        def configure_permitted_parameters
            puts "******* configure_permitted_parameters *******"
            devise_parameter_sanitizer.permit(:sign_up) {
                |u| u.permit({ roles: [] }, :fname, :lname, :username, :email, :password, :password_confirmation)
            }
            devise_parameter_sanitizer.permit(:account_update) {
                |u| u.permit(:fname, :lname, :username, :email, :password, :password_confirmation)
            }
        end
end
