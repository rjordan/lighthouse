# frozen_string_literal: true
require 'rails_helper'

describe 'Swarm deletion', type: :feature do
  let(:swarm) { FactoryGirl.create(:swarm) }

  before do
    allow(swarm).to receive(:connection).and_return(nil)
    visit '/swarms'
    within('tr[data-id]') do
      server_link = page.find('td > a')
      server_link.click
    end
  end

  it { expect(page).to have_selector('h1', text: swarm.name) }
end
