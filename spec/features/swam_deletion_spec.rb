# frozen_string_literal: true
require 'rails_helper'

describe 'Swarm deletion', type: :feature do
  before do
    FactoryGirl.create(:swarm)
    visit '/swarms'
    within('tr[data-id]') do
      delete = page.find('div.list-buttons > a.danger-button')
      delete.click
    end
  end

  it { expect(page).to have_content('Swarm Unregistered') }
end
