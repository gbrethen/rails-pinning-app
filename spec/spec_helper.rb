ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed # loading seeds
  end
  
end

def login(user)
	logged_in_user = User.authenticate(user.email, user.password)
	if logged_in_user.present?
		session[:user_id] = logged_in_user.id
	end
end

def logout(user)
	if session[:user_id] == user.id
		session.delete(:user_id)
	end
end