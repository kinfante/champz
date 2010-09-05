class LoginController < ApplicationController
  def index
    @total_championships = Championship.count
  end

  def login
    clear_session
    if request.post?
      user = User.authenticate(params[:login], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :controller => 'main', :action => "index" })
      else
        flash[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    clear_session
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

end
