require 'capybara/rails'
require 'capybara/rspec'
RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = if example.metadata[:js]
                                 :truncation
                               else
                                 :transaction
                               end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
