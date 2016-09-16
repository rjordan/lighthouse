# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Swarm, type: :model do
  it { should respond_to(:name) }
end
