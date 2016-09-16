# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SwarmsController, type: :controller do
  describe 'the swarm list endpoint' do
    before do
      get :index
    end
    it { expect(response.status).to eq(200) }
    # it { expect(assigns(:swarms)).to_not be_nil }
    # it { expect(subject).to_not set_flash }
    # it { expect(subject).to render_template(:index) }
  end

  describe 'the swarm registration endpoint' do
    before do
      get :new
    end
    it { expect(response.status).to eq(200) }
  end
end
