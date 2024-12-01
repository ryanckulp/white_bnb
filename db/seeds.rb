# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

raise StandardError, "DO NOT RUN THIS IN PRODUCTION" if Rails.env.production?

puts "creating default Settings..."
settings = [
  { key: 'host_phone_number', value: '+1 555-867-5309' },
  { key: 'host_email', value: 'hq@founderhacker.com' },
  { key: 'per_night_price', value: 130 },
  { key: 'minimum_stay_length', value: 4 },
  { key: 'check_in_time', value: '12pm' },
  { key: 'check_out_time', value: '12pm' },
  { key: 'manual', value: nil }, # ex: link to Google Doc
  { key: 'arrival_guide', value: nil } # ex: link to Google Doc
]

settings.each { |setting| Setting.find_or_create_by(setting) }

puts "creating default Add-ons..."
addons = [
  { title: 'Pair Program (Ruby or JavaScript)', description: "Build features, fix bugs, model databases.<br>Two hour block.", price: 199 },
  { title: 'Brainstorm Session (Product)', description: "Scope a project, customer development, marketing brainstorm, etc.<br>Two hour block.", price: 299 },
  { title: 'Airport Shuttle', description: 'Round trip transportation by me (Ryan, host), a 60% savings on Uber.', price: 99 }
]

addons.each { |addon| Addon.find_or_create_by(addon) }

puts "creating sample Review..."
Review.find_or_create_by!(title: "Awesome", body: "Loved my stay here.", name: "Ryan Kulp", job_title: "Founder, TRMNL", email: "ryanckulp@gmail.com", approved: true)

puts "creating sample Announcement (Changelog entry)..."

ann = Announcement.find_or_initialize_by(title: "We. Are. Live.", version: "0.0.1", date: '2024-10-07')
ann.body = "Now accepting guests!"
ann.save

require 'seed_support/rewardful'
puts "setting up Rewardful affiliate program..."
SeedSupport::Rewardful.run
