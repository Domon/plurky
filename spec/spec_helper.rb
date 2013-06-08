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
