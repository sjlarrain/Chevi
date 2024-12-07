class ApplicationController < ActionController::Base
    # Protect from CSRF attacks by raising an exception
    protect_from_forgery with: :exception
  
    # Ensure the professional is authenticated before accessing any page
    before_action :authenticate_professional!
  
    # Customize redirection after signing in
    def after_sign_in_path_for(resource)
      home_index_path # Redirect to the home index view
    end
  
    # Customize redirection after signing out
    def after_sign_out_path_for(resource_or_scope)
      new_professional_session_path # Redirect to Devise login page
    end
  
    # Permit additional parameters for Devise if needed
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
    end
  end
  