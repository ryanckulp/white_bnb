# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

raise StandardError, "DO NOT RUN THIS IN PRODUCTION" if Rails.env.production?

puts "creating default Settings..."
settings = [
  { key: 'host_phone_number', value: '+1 555-867-5309' },
  { key: 'host_email', value: 'hq@founderhacker.com' },
  { key: 'per_night_price', value: 130 },
  { key: 'minimum_nights', value: 4 }, # TODO: enforce this logic on /book
  { key: 'check_in_time', value: '12pm' },
  { key: 'check_out_time', value: '12pm' }
]

settings.each { |setting| Setting.find_or_create_by(setting) }

puts "creating default Add-ons..."
addons = [
  { title: 'Consulting Session (Ruby on Rails only)', description: "Pair program, fix bugs, architect features.<br>Two hour block.", price: 199 },
  { title: 'Airport Shuttle', description: 'Round trip transportation by me (Ryan, host), a 50% savings on Uber.', price: 99 }
]

addons.each { |addon| Addon.find_or_create_by(addon) }

require 'seed_support/rewardful'
puts "setting up Rewardful affiliate program..."
SeedSupport::Rewardful.run
