# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  skip_before_filter :login_required

  # render new.rhtml
  def new
  end

  def create
    params[:login] = params[:login].downcase
    self.current_user = current_site.users.authenticate(params[:login], params[:password])
    
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me
        cookies[:auth_token] = { :value => current_user.remember_token , :expires => current_user.remember_token_expires_at }
      end
      redirect_back_or_default('/')
      flash[:notice] = t(:logged_in_successfully)
    else
      flash[:error] = t(:invalid_login)
      render :action => 'new'
    end
  end

  def destroy
    current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = t(:you_have_been_logged_out)
    redirect_back_or_default('/')
  end
end
