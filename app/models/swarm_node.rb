# frozen_string_literal: true
class SwarmNode
  attr_accessor :hostname, :role, :availability, :os, :architecture,
                :engine_version, :status

  def self.from_json(data)
    sn = SwarmNode.new
    sn.hostname = data.dig('Description', 'Hostname')
    sn.role = data.dig('Spec', 'Role')
    sn.availability = data.dig('Spec', 'Availability')
    sn.os = data.dig('Description', 'Platform', 'OS')
    sn.architecture = data.dig('Description', 'Platform', 'Architecture')
    sn.engine_version = data.dig('Description', 'Engine', 'EngineVersion')
    sn.status = data.dig('Status', 'State')
    sn.role = 'leader' if data.dig('ManagerStatus', 'Leader')
    sn
  end
end
