require 'rails_helper'

RSpec.describe Coach, type: :model do
  # Test validations
  context 'validations' do
    it 'is valid with valid attributes' do
      coach = FactoryBot.build(:coach) # Create a valid coach using the factory
      expect(coach).to be_valid
    end

    it 'is invalid without a first_name' do
      coach = FactoryBot.build(:coach, first_name: nil)
      expect(coach).to_not be_valid
      expect(coach.errors[:first_name]).to include("can't be blank")
    end

    it 'is invalid without a last_name' do
      coach = FactoryBot.build(:coach, last_name: nil)
      expect(coach).to_not be_valid
      expect(coach.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      coach = FactoryBot.build(:coach, email: nil)
      expect(coach).to_not be_valid
      expect(coach.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email' do
      FactoryBot.create(:coach, email: "duplicate@example.com") # Create a coach with this email
      duplicate_coach = FactoryBot.build(:coach, email: "duplicate@example.com") # Attempt duplicate
      expect(duplicate_coach).to_not be_valid
      expect(duplicate_coach.errors[:email]).to include("has already been taken")
    end
  end
  
end
