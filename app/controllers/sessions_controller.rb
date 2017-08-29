class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:notice] = "Already logged in"
      redirect_to current_user
    end
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
