class ApplicationController < ActionController::Base
    protect_from_forgery prepend: true, with: :exception      
    skip_before_action :verify_authenticity_token 
    
    def require_admin # This is from Blazer..
        # depending on your auth, something like...
        redirect_to root_path unless current_user && current_user.admin?
    end
end
