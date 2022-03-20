class ApplicationController < ActionController::Base
  helper_method :premium_user_check
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:alert] = 'You must be logged in to perform that action.'
    redirect_to login_path
  end

  def premium_user_check
    return true if !!current_user && condition2
  end

  def condition2
    (current_user.subscription_status == 'active' || current_user.admin?)
  end
end
