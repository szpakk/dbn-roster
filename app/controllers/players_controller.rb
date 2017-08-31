class PlayersController < ApplicationController
  before_action :logged_in_admin
  
  def new  
  end

  def edit
    @player = Player.find_by(id: params[:id])
  end

  def update
    @player = Player.find_by(id: params[:id])
    @player.attributes = player_params
    if @player.save
      flash[:notice] = "Player succesfully updated"
      redirect_to players_path
    else
      flash[:warning] = @player.errors.full_messages.first
      render 'edit'
    end

  end
 
  def create
    @player = Player.new(name: params[:name], position: params[:position], active: params[:active])
    if @player.save
      flash[:notice] = "Player succesfully created"
      redirect_to players_path
    else
      flash[:warning] = @player.errors.full_messages.first
      render 'new'
    end
  end

  def index
    @players = Player.all.order(:name)
  end

  def destroy
    @player = Player.find_by(id: params[:id])
    @player.destroy
    flash[:notice] = "Player succesfully deleted"
    redirect_to players_path
  end

  def logged_in_admin
    unless logged_in? && current_user.admin?
      flash[:danger] = "Access denied."
      redirect_back(fallback_location: root_path)
    end
  end

  def player_params
    params.permit(:name, :position, :active)
  end
end
