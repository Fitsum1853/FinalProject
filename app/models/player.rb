class Player < ApplicationRecord
    has_and_belongs_to_many :teams
    def full_name
        "#{first_name} #{last_name}"
      end
end
