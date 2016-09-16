# frozen_string_literal: true
require 'rails_helper'

describe 'The swarm registration page', type: :feature do
  before do
    visit '/swarms/new'
    fill_in('Swarm Nodes', with: '10.0.0.1')
    click_button('Register Swarm')
  end
  it { expect(page).to have_content('Swarm Registered') }
end
