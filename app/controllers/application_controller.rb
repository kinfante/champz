# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "championships"
  before_filter :authorize, :except => [:login, :show, :complete_openid_auth]
  before_filter :set_user_logged

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3b2d2912987a2df0ffcdd1d3b371eb48'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected
    def authorize
      unless session[:user_id]
        session[:original_uri] = request.request_uri
        flash[:notice] = "Please log in"
        redirect_to :controller => 'login', :action => 'login'
      end
    end

    def clear_session
      session[:user_id] = nil
    end

    def set_user_logged
      if session[:user_id]
        @user_logged = User.find_by_id(session[:user_id])
      end
    end
end
