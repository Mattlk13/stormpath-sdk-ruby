# Note: If SimpleCov starts after your application code is already loaded (via require),
# it won't be able to track your files and their coverage! The SimpleCov.start must be
# issued before any of your application code is required!
require 'simplecov'
SimpleCov.start do
  add_filter { |src| src.filename =~ /spec/ }
end

require 'stormpath-sdk'
require 'pry'
require 'webmock/rspec'
require 'vcr'
require 'jwt'
require 'uuidtools'

Dir['./spec/support/*.rb'].each { |file| require file }

HIJACK_HTTP_REQUESTS_WITH_VCR = ENV['STORMPATH_SDK_TEST_ENVIRONMENT'] != 'CI'

WebMock.allow_net_connect!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_request { |r| HIJACK_HTTP_REQUESTS_WITH_VCR == false }
end

RSpec.configure do |c|
  c.mock_with :rspec do |cm|
    cm.syntax = :expect
  end

  c.expect_with :rspec do |ce|
    ce.syntax = :expect
  end

  c.include Stormpath::Test::ApiKeyHelpers
  c.include Stormpath::Test::EnvNamesWarning
  c.include Stormpath::Test::RandomResourceNameGenerator
  c.include Stormpath::Test::ResourceHelpers

  Stormpath::Test::EnvNamesWarning.check_env_variable_names
end
