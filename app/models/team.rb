class Team < ApplicationRecord
  belongs_to :coach
  has_and_belongs_to_many :players
  has_many :events, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :coach_id, message: "already exists for this coach" }
end
