# frozen_string_literal: true
ElasticSearchConfig = YAML.load(File.read(Rails.root.join('config', 'elasticsearch.yml')))
