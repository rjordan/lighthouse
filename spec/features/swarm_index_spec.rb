# frozen_string_literal: true
require 'rails_helper'

describe 'The swarm index page', type: :feature do
  before do
    visit '/swarms'
  end
  it { expect(page).to have_link('Register Swarm', href: '/swarms/new') }
end
