# frozen_string_literal: true
FactoryGirl.define do
  factory :swarm do
    swarm_id { SecureRandom.uuid }
    name { Faker::Lorem.words(2).join(' ') }
    swarm_nodes 'localhost:2345'
  end
end
