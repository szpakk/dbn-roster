class Roster < ApplicationRecord
  has_many :selections
  has_many :players, :through => :selections

  validates :players, presence: true, size: { minimum: 1 }
end
