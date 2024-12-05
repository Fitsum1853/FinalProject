class Coach < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :teams, dependent: :destroy

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
end
