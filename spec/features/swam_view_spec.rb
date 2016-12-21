# frozen_string_literal: true
require 'rails_helper'

describe 'Swarm details', type: :feature do
  let!(:swarm) { FactoryGirl.create(:swarm) }

  before do
    allow_any_instance_of(Swarm).to receive(:nodes).and_return([])
    allow_any_instance_of(Swarm).to receive(:services).and_return([])
    visit '/swarms'
    within("tr[data-id='#{swarm.id}']") do
      server_link = page.find('td > a')
      server_link.click
    end
  end

  it { expect(page).to have_selector('h2', text: swarm.name) }
end
