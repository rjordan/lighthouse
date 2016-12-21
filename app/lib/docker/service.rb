# frozen_string_literal: true
module Docker
  class Service
    attr_reader :id, :name, :image, :environment, :scale

    def initialize(data)
      parse_service_data(data)
    end

    private

    # rubocop:disable MethodLength
    def parse_service_data(data)
      @id = data.dig('ID')
      @name = data.dig('Spec', 'Name')
      @image = data.dig('Spec', 'TaskTemplate', 'ContainerSpec', 'Image')
      @environment = Array(data.dig('Spec', 'TaskTemplate', 'ContainerSpec', 'Env'))
      mode = data.dig('Spec', 'Mode').first.first
      @scale = case mode
               when 'Replicated'
                 data.dig('Spec', 'Mode', 'Replicated', 'Replicas')
               when 'Global'
                 'global'
               else
                 raise "Bad replication mode: #{mode}"
               end
    end
  end
end
