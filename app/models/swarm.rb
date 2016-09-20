# frozen_string_literal: true
class Swarm < ApplicationRecord
  # Docker API endpoint docs
  # https://docs.docker.com/engine/reference/api/docker_remote_api_v1.24/#/list-nodes
  attr_accessor :manager_token, :worker_token

  def update_swarm_info!
    # 192.168.0.100:2375
    swarm = JSON.parse(RestClient.get("#{swarm_nodes}/swarm").body)
    self.swarm_id = swarm['ID']
    save!
    self.manager_token = swarm['JoinTokens']['Manager']
    self.worker_token = swarm['JoinTokens']['Worker']
  end

  def node_info
    node_info = JSON.parse(RestClient.get("#{swarm_nodes}/nodes").body)
    puts node_info
  end
end
