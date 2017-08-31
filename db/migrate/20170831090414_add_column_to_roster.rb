class AddColumnToRoster < ActiveRecord::Migration[5.1]
  def change
    add_column :rosters, :final, :boolean, default: :false
  end
end
