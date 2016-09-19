# frozen_string_literal: true
require 'rails_helper'

describe 'Swarm registration', type: :feature do
  before do
    visit '/swarms'
    click_link 'Register Swarm'
    fill_in('Name', with: Faker::Lorem.words(2).join(' '))
    fill_in('Swarm Nodes', with: '10.0.0.1')
    click_button('Register Swarm')
  end
  it { expect(page).to have_content('Swarm Registered') }
end
