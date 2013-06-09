require 'coveralls'

Coveralls.wear!

require 'webmock/rspec'
require 'plurky'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    # Enable only the `expect` syntax
    c.syntax = :expect
  end
end

def plurk_url(path)
  URI.join(Plurky::Default::ENDPOINT, path).to_s
end

def a_get(path, query = {})
  a_request(:get, plurk_url(path)).with(:query => query)
end

def stub_get(path, query = {})
  stub_request(:get, plurk_url(path)).with(:query => query)
end

def fixtures_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture_path(file)
  File.join(fixtures_path, file)
end

def fixture(file)
  File.new(fixture_path(file))
end

def json_response(file)
  {
    :body => fixture(file),
    :headers => {
      :content_type => "application/json; charset=utf-8"
    }
  }
end
