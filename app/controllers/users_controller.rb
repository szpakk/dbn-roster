class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.create(:name => params[:name], :password => params[:password], :password_confirmation => params[:password])
    log_in @user
    redirect_to new_roster_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def show
    user = User.find(params[:id])
    roster = Roster.where(:user_id => user.id).first
    if roster.nil?
      redirect_to new_roster_path
    else 
      redirect_to roster_path(roster)
    end
  end
end
