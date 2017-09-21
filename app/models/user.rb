class User < ApplicationRecord
  validates :name, presence: true, length: { in: 2..30 },
                                   uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validate  :password_validation
  has_secure_password

  has_one :roster

  private

  def password_validation
    errors.add(:password, "can't be identical to username") if password == name;
    errors.add(:password, "can't contain spaces") if password =~ /\s+/
    errors.add(:password, "has to contain at least one digit") if password !~ /\d+/
    errors.add(:password, "has to contain at least one uppercase letter") if password !~ /[A-Z]+/
    errors.add(:password, "has to contain at least one lowercase letter") if password !~ /[a-z]+/
  end
end
