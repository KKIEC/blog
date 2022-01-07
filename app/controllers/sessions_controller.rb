class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user_authentication(user)
      session_assignment(user)
    else
      flash.now[:alert] = 'Invalid login details.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end

  private

  def session_assignment(user)
    session[:user_id] = user.id
    flash[:notice] = 'Logged in successfully'
    redirect_to user
  end

  def user_authentication(user)
    user.authenticate(params[:session][:password])
  end
end
