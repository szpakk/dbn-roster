class Roster < ApplicationRecord
  has_many :selections
  has_many :players, through: :selections
end
