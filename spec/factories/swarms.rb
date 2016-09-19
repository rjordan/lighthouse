# frozen_string_literal: true
FactoryGirl.define do
  factory :swarm do
    swarm_id 'MyString'
    name { Faker::Lorem.words(2).join(' ') }
  end
end
