class AddUserToRoster < ActiveRecord::Migration[5.1]
  def change
    add_reference :rosters, :user, foreign_key: true
  end
end
