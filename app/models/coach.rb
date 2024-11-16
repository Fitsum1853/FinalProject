class Coach < ApplicationRecord
    has_many :teams, dependent: :destroy
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
end
