# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Swarm, type: :model do
  it { should respond_to(:name) }

  describe '.swarm_info' do
    before do
      allow(subject).to receive(:swarm_endpoints).and_return(['10.0.0.1:2375'])
      stub_request(:get, 'http://10.0.0.1:2375/swarm').to_return(status: 200, body: '{"ID":"1234","JoinTokens":{"Manager":"5678","Worker":"8765"}}')
      subject.swarm_info
    end
    it { expect(subject.swarm_id).to eq('1234') }
    it { expect(subject.manager_token).to eq('5678') }
    it { expect(subject.worker_token).to eq('8765') }
  end
end
