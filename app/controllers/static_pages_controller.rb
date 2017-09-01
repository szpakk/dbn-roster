class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to roster_path(current_user.roster)
    end
  end
end
