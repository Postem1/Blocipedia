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

  #Create a standard member
  standard = User.create!(
    email:    'standard@example.com',
    password: 'password'
    )
    standard.standard!
    standard.skip_confirmation!
    standard.save!

  #Create another premium member
  premium2 = User.create!(
    email:    'premium2@example.com',
    password: 'password'
    )

    premium2.premium!
    premium2.skip_confirmation!
    premium2.save!



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
      user: users.last
)

private_wiki2 = Wiki.create(
      title:  "Private Wiki2",
      body: Faker::Lorem.paragraph,
      private: true,
      user: users.last
)


md_wiki = Wiki.create(
  title: "My Markdown List Wiki",
  private: false,
  user: users.last,
  body:
  %Q{### *My List of Things To Do!*

  Here is the list of things I wish to do!

  * _write more posts_
  * write even more posts
  * ~~write even more posts!~~

```
puts 'hello world'
```
}
)

  wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
