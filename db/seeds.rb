# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

raise StandardError, "DO NOT RUN THIS IN PRODUCTION" if Rails.env.production?

puts "creating default Settings..."
settings = [
  { key: 'per_night_price', value: 130 },
  { key: 'minimum_nights', value: 4 }
]

settings.each { |setting| Setting.find_or_create_by(setting) }

require 'seed_support/rewardful'
puts "setting up Rewardful affiliate program..."
SeedSupport::Rewardful.run
