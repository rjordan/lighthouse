# frozen_string_literal: true
module Docker
  class Repository
    def initialize(endpoint)
      @endpoint = endpoint
    end

    # http://localhost:5000/v2/_catalog
    def catalog
      call_repository_api(:get, '/v2/_catalog').dig('repositories')
    end

    # http://127.0.0.1:5000/v2/oauth2_proxy/tags/list
    def image_tags(image_name)
      call_repository_api(:get, "/v2/#{image_name}/tags/list").dig('tags')
    end

    private

    def call_repository_api(method, endpoint, data = nil)
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
