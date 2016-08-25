# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create Users
10.times do
  user = User.new(
        email:  Faker::Internet.email,
        password: 'password'
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

u = User.new(
      email:  "spostemus@gmail.com",
      password: 'password',
      role: 2
)
u.skip_confirmation!
u.save!

# Create Wikis
10.times do
  wiki = Wiki.create(
        title:  Faker::StarWars.character,
        body: Faker::Lorem.paragraph,
        private: [false, true].sample,
        user: users.sample
  )
end
  wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
