require 'rails_helper'


RSpec.describe "Coaches", type: :system do
 describe "Coaches Registration" do
    # New user with correct information
   context "new user with correct information" do
     it "allows a user to sign up" do
       visit new_coach_registration_path
       fill_in "First name", with: "Capybara"
       fill_in "Last name", with: "Rspec"
       fill_in "Password", with: "password"
       fill_in "Email", with: "cr@gmail.com"
       fill_in "Password", with: "password"    
       fill_in "Password confirmation", with: "password"
       click_button "Sign up"
       expect(page).to have_content("Welcome! You have signed up successfully.")
     end
   # New user with incorrect information
   end
 end #end describe student registration testing
end

