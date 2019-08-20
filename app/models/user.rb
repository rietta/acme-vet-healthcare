class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Users are by default visitors, which is set by the database
  enum role: { visitor: 0, admin: 1 }

  # Thanks to Rails magic, this enum creates the methods
  # visitor?, and admin? which return true/false
  # depending on the type of user. A visitor that has a valid
  # vet registration number is a veterinarian?, defined here:

  def veterinarian?
    visitor? && vet_registration_number.present?
  end

  validates(
    :vet_registration_number,
    allow_nil: true,
    allow_blank: true,
    uniqueness: true,
    format: { 
      with: /\AVR\d{4,}\z/, 
      message: 'must be a valid state Doctor identifier' 
    }
  )
end
