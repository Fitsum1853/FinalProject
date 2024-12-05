FactoryBot.define do
  factory :coach do
    first_name { "John" }
    last_name { "Doe" }
    email { "coach1@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
