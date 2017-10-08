ENV['PATH'] = "#{Dir.pwd}/bin#{File::PATH_SEPARATOR}#{ENV['PATH']}"

require 'bundler/setup'
require 'aruba'
require 'aruba/api'
require 'pry'
require 'simplecov'
require 'codecov'

SimpleCov.start { add_filter 'spec/*' }
#SimpleCov.formatter = SimpleCov::Formatter::Codecov
SimpleCov.minimum_coverage 100

SimpleCov.at_exit do
  SimpleCov.result.format!# unless $!
end

require 'mcli'

require './spec/support/support'

Aruba.configure do |config|
  # use current working directory
  config.home_directory = './bin/'
end

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
