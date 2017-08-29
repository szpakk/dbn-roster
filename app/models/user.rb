class User < ApplicationRecord
  validates :name, presence: true, length: { in: 2..30 },
                                   uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 3 }
  has_secure_password

  has_one :roster
end
