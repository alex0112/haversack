require "bundler/setup"
require "haversack"
require "haversack/itemcollection"
require "factory_bot"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  ## Fail fast
  config.fail_fast = true
  
  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  ## Factory Bot
  config.include FactoryBot::Syntax::Methods
  
  config.before(:suite) do
    FactoryBot.find_definitions
  end
  
end
