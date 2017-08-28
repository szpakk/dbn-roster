class RostersController < ApplicationController
  def new
    @players = Player.all
  end

  def create
    @roster = Roster.new
    params[:players].each { |player| @roster.players << Player.find(player) }
    @roster.save
    redirect_to roster_path(@roster)
  end

  def show
    @roster = Roster.find(params[:id])
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
