# frozen_string_literal: true
Aws.config.update(
  region: 'us-east-1',
  credentials: Aws::SharedCredentials.new
)
