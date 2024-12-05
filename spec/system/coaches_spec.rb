require 'rails_helper'

RSpec.describe "Coaches", type: :system do
  describe "Coaches Registration" do
    # Happy Path: New user with correct information
    context "new user with correct information" do
      it "allows a user to sign up" do
        visit new_coach_registration_path
        fill_in "First name", with: "Capybara"
        fill_in "Last name", with: "Rspec"
        fill_in "Email", with: "cr@gmail.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
    end

    # Sad Path: New user with incorrect information
    context "new user with incorrect information" do
      it "displays errors for missing required fields" do
        visit new_coach_registration_path
        fill_in "First name", with: ""
        fill_in "Last name", with: ""
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        fill_in "Password confirmation", with: ""
        click_button "Sign up"
        expect(page).to have_content("First name can't be blank")
        expect(page).to have_content("Last name can't be blank")
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
      end

      it "displays an error for mismatched passwords" do
        visit new_coach_registration_path
        fill_in "First name", with: "Capybara"
        fill_in "Last name", with: "Rspec"
        fill_in "Email", with: "cr@gmail.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "wrongpassword"
        click_button "Sign up"
        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      it "displays an error for duplicate email" do
        # Create a coach first
        FactoryBot.create(:coach, email: "duplicate@example.com", password: "password123")

        # Attempt to sign up with the same email
        visit new_coach_registration_path
        fill_in "First name", with: "Capybara"
        fill_in "Last name", with: "Duplicate"
        fill_in "Email", with: "duplicate@example.com"
        fill_in "Password", with: "password123"
        fill_in "Password confirmation", with: "password123"
        click_button "Sign up"
        expect(page).to have_content("Email has already been taken")
      end
    end
  end

  describe "Coaches Login" do
    let(:coach) { FactoryBot.create(:coach, password: "password123", password_confirmation: "password123") }

    context "valid login" do
      it "allows a coach to log in" do
        visit new_coach_session_path
        fill_in "Email", with: coach.email
        fill_in "Password", with: "password123"
        click_button "Log in"
        expect(page).to have_content("Signed in successfully.")
      end
    end

    context "invalid login" do
      it "displays an error for invalid credentials" do
        visit new_coach_session_path
        fill_in "Email", with: "wrong_email@example.com"
        fill_in "Password", with: "wrongpassword"
        click_button "Log in"
        expect(page).to have_content("Invalid Email or password.")
      end
    end
  end
end
