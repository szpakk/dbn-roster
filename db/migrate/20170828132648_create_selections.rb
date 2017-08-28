class CreateSelections < ActiveRecord::Migration[5.1]
  def change
    create_table :selections do |t|
      t.belongs_to :roster, index: true
      t.belongs_to :player, index: true
      t.timestamps
    end
  end
end
