class RostersController < ApplicationController
  def new
    if !logged_in?
      redirect_to login_path
    elsif !current_user.roster.nil?
      redirect_to current_user.roster
    else 
      @players = Player.all
    end
  end

  def create
    @roster = Roster.new
    params[:players].each { |player| @roster.players << Player.find(player) }
    @roster.user_id = session[:user_id]
    @roster.save
    redirect_to roster_path(@roster)
  end

  def show
    @roster = Roster.find_by(id: params[:id])
    if current_user.roster.nil?
      redirect_to new_roster_path
    elsif @roster != current_user.roster
      redirect_to current_user.roster
    end
  end

  def edit
    @roster = Roster.find(params[:id])
    @players = Player.all
  end

  def update
    @roster = Roster.find(params[:id])
    @roster.selections.delete_all
    params[:players].each { |player| @roster.players << Player.find(player) }
    @roster.save
    redirect_to roster_path(@roster)
  end

  def index
    @rosters = Roster.all
  end

  def destroy
    @roster = Roster.find(params[:id])
    @roster.selections.delete_all
    @roster.delete
    redirect_to new_roster_path
  end
end
