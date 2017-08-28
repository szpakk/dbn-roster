class AddActiveColumnToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :active, :boolean, :default => :true
  end
end
