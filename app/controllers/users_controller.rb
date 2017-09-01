class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Sign up complete!"
      redirect_to new_roster_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def show
    user = User.find_by(id: params[:id])
    roster = Roster.find_by(:user_id => user.id) if user
    if roster.nil?
      redirect_to new_roster_path
    else 
      redirect_to roster_path(roster)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
