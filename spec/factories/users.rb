require 'faker'

FactoryGirl.define do
  factory :user do
    email   { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    confirmed_at Date.today
  end

  factory :admin, class: User do
    email   { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    confirmed_at Date.today
    role 2
  end

  factory :premium, class: User do
    email   { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    confirmed_at Date.today
    role 1
  end
end
