require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  RSpec.configure do |config|
    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end
  
    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end