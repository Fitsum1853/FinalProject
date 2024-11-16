class ApplicationController < ActionController::Base
    #configure_permitted_parameters: method runs before each Devise controller action.
    before_action :configure_permitted_parameters, if: :devise_controller?
 
    #protected methods in class
    protected
 
 #override configure_permitted_parameters method to allow additional parameters
   #by default devise only allows email, password and password_confirmation
   def configure_permitted_parameters
       # parameters allowed during sign up
       devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
       # parameters that can be updated
       devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
   end

      #override after_sign_in_path_for method that is called by Devise
   def after_sign_in_path_for(resource)
       # Redirect to the student's profile using devise method current_student
       coach_path(current_coach) # Redirect to the logged-in student's profile
   end

 end 