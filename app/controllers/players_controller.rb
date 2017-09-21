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
      flash[:success] = "Player succesfully updated"
      redirect_to players_path
    else
      flash[:danger] = @player.errors.full_messages.first
      redirect_to edit_player_path(@player)
    end

  end
 
  def create
    @player = Player.new(name: params[:name], position: params[:position], active: params[:active])
    if @player.save
      flash[:success] = "Player succesfully created"
      redirect_to players_path
    else
      flash[:danger] = @player.errors.full_messages.first
      render 'new'
    end
  end

  def index
    @players = Player.all.order(:name)
  end

  def destroy
    @player = Player.find_by(id: params[:id])
    if @player.destroy
      flash[:success] = "Player succesfully deleted"
    else
      flash[:danger] = "Unable to destroy player"
    end
    redirect_to players_path
  end

  private

  def player_params
    params.permit(:name, :position, :active)
  end
end
