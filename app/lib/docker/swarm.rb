# frozen_string_literal: true
module Docker
  class Swarm
    # Docker API endpoint docs
    # https://docs.docker.com/engine/reference/api/docker_remote_api_v1.24/#/list-nodes

    def initialize(endpoint)
      # TODO: handle collection of endpoints
      @endpoint = endpoint
    end

    def nodes
      call_docker_api(:get, '/nodes')
    end

    def swarm_info
      call_docker_api(:get, '/swarm')
    end

    private

    def call_docker_api(method, endpoint, data = nil)
      raise 'Not yet implemented!' if data
      JSON.parse(connection.send(method, endpoint).body)
    end

    def connection
      @connection ||= Faraday.new(URI.parse(@endpoint), {}) do |conn|
        conn.request  :url_encoded             # url-encode POST params
        conn.response :logger                  # log requests to STDOUT
        conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end
