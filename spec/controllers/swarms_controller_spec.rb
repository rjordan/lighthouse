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

  describe 'the swarm registration endpoint' do
    before do
      # allow_any_instance_of(Swarm).to receive(:connection).and_return(
      #   Faraday.new do |builder|
      #     builder.adapter :test do |stub|
      #       stub.get('/swarm') { |_env| [200, {}, '{"ID":"1234"}'] }
      #     end
      #   end
      # )
      post :create, params: { swarm: { swarm_nodes: '10.0.0.1' } }
    end
    it { expect(response.status).to eq(302) }
  end
end
