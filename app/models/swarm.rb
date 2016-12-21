# frozen_string_literal: true
class Swarm < ApplicationRecord
  attr_reader :manager_token, :worker_token
  # before_create :update_swarm_id

  # Worker icon = cog
  # Manager icon = sitemap
  # Leader icon = flag

  def swarm_info
    swarm = swarm_master.swarm_info
    self.swarm_id = swarm['ID']
    @manager_token = swarm.dig('JoinTokens', 'Manager')
    @worker_token = swarm.dig('JoinTokens', 'Worker')
  end

  def node_info
    swarm_master.nodes.map { |n| SwarmNode.from_json(n) }
  end

  private

  def swarm_master
    @swarm_master ||= Docker::Swarm.new("http://#{swarm_endpoints.first}")
  end

  #  after_find do
  #    swarm_info
  #  end

  def swarm_endpoints
    if swarm_nodes.include?(',')
      swarm_nodes.split(',')
    else
      Array(swarm_nodes)
    end.map { |n| n.include?(':') ? n : "#{n}:2375" }
  end

  def update_swarm_id
    swarm_info
  end
end
