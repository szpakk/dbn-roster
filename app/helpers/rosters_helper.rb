module RostersHelper
  def final_roster
    admin = User.find_by(:admin => true)
    Roster.where(:user_id => admin.id)
  end
end
