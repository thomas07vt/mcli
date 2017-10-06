ENV['PATH'] = "#{Dir.pwd}/bin#{File::PATH_SEPARATOR}#{ENV['PATH']}"

require 'bundler/setup'
require 'aruba'
require 'aruba/api'
require 'pry'

require 'simplecov'
SimpleCov.start { add_filter 'spec/*' }
require 'codecov'
#SimpleCov.formatter = SimpleCov::Formatter::Codecov
SimpleCov.minimum_coverage 100

require 'mcli'

require './spec/support/support'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.include Aruba::Api
  config.include Support

  config.before(:all) { setup_aruba }

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
