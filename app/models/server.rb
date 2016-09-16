# frozen_string_literal: true
class Server < ApplicationRecord
  ANSIBLE_RESULT_REGEX = /(?<hostname>.*) \| (?<status>.*) => (?<result>.*)/m

  def call_ansible(action)
    result = `ansible #{action}`
    md = ANSIBLE_RESULT_REGEX.match(result)
    vals = Hash[md.names.zip(md.captures)]
    vals['result'] = JSON.parse(vals['result']) if vals['status'] == 'SUCCESS'
  end

  def facts
    @facts ||= call_ansible("-m setup #{name}")&.dig('ansible_facts') || {}
  end

  def facts_loaded
    time = facts.dig('ansible_date_time', 'iso8601_micro')
    time.blank? ? 'UNKNOWN' : Time.parse(time)
  end

  def self.client
    @client ||= Elasticsearch::Client.new log: true, host: @@elastic_config['hosts'].first
  end

  def self.find_all
    client.search(body: '{"size": 0, "aggs": { "hosts": {"terms": {"field": "host.raw", "size": 255}}}}').dig('aggregations', 'hosts', 'buckets').map { |v| v['key'] }
  end
end
