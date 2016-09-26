# frozen_string_literal: true
class Swarm < ApplicationRecord
  # Docker API endpoint docs
  # https://docs.docker.com/engine/reference/api/docker_remote_api_v1.24/#/list-nodes
  attr_reader :manager_token, :worker_token
  # before_create :update_swarm_id

  # Worker icon = cog
  # Manager icon = sitemap
  # Leader icon = flag

  def swarm_info
    swarm = JSON.parse(connection.get('/swarm').body)
    self.swarm_id = swarm['ID']
    @manager_token = swarm.dig('JoinTokens', 'Manager')
    @worker_token = swarm.dig('JoinTokens', 'Worker')
  end

  def node_info
    JSON.parse(connection.get('/nodes').body).map { |n| SwarmNode.from_json(n) }
  end

  private

  after_find do
    swarm_info
  end

  def swarm_endpoints
    swarm_nodes.split(',').map { |n| n.include?(':') ? n : "#{n}:2375" }
  end

  def connection
    @connection ||= Faraday.new(URI.parse("http://#{swarm_endpoints.first}"), {}) do |conn|
      conn.request  :url_encoded             # url-encode POST params
      conn.response :logger                  # log requests to STDOUT
      conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def update_swarm_id
    swarm_info
  end
end
