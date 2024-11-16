# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed Players
players = [
  { first_name: 'Alice', last_name: 'Smith', email: 'alice@example.com' },
  { first_name: 'Bob', last_name: 'Jones', email: 'bob@example.com' },
  { first_name: 'Charlie', last_name: 'Brown', email: 'charlie@example.com' },
  { first_name: 'Diana', last_name: 'White', email: 'diana@example.com' },
  { first_name: 'Eve', last_name: 'Black', email: 'eve@example.com' }
]

players.each do |player_data|
  Player.create!(player_data)
end