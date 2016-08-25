require 'faker'

FactoryGirl.define do
  factory :wiki do
    title { Faker::Company.name }
    body { Faker::Lorem.paragraph }
    private false
  end
end
