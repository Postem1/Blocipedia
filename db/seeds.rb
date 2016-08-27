# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create Users
20.times do
  user = User.new(
        email:  Faker::Internet.email,
        password: 'password'
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

admin = User.new(
      email:  "admin@example.com",
      password: 'password'
)
admin.admin!
admin.skip_confirmation!
admin.save!

#Create a premium member
premium = User.create!(
  email:    'premium@example.com',
  password: 'password'
  )
  premium.premium!
  premium.skip_confirmation!
  premium.save!

  #Create a premium member
  standard = User.create!(
    email:    'standard@example.com',
    password: 'password'
    )
    standard.premium!
    standard.skip_confirmation!
    standard.save!

# Create Wikis
40.times do
  wiki = Wiki.create(
        title:  Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        private: false,
        user: users.sample
  )
end

private_wiki = Wiki.create(
      title:  "Private Wiki",
      body: Faker::Lorem.paragraph,
      private: true,
      user: users.sample
)
  wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
