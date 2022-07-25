class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :role_id, :password_confirmation) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
    end




    def after_sign_in_path_for(resource)

     

        if current_user.role.name == "admin" 
            admins_admins_path
        else
            developers_developers_path
        end
       
    end

    private
      
        def user_not_authorized
          flash[:alert] = 'You are not authorized to perform this action.'
          redirect_to developers_developers_path
        end
end
