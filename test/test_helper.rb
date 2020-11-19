ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/autorun'
require 'minitest/pride'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json
    JSON.parse(response.body)
  end

  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers(user_id)
    {
      "Authorization" => token_generator(user_id),
      "Content-Type" => "application/json"
    }
  end

  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end

  def login_with_feelings
    # @user = User.create(first_name: 'jim', last_name: 'pub', email: 'jim@home.com', password: 'testingpassword')
    # puts "-------@user.inspect: #{@user.inspect}-------"
    # @headers = valid_headers(@user.id).except('Authorization')
    # puts @headers.inspect
    # @valid_creds = { email: @user.email, password: @user.password }.to_json
    # post auth_login_path, headers: @headers, params: @valid_creds
    # # byebug
    # puts '----------'
    # puts json
    # puts '----------'
    # @headers['Authorization'] = json['Authorization']
    # # puts @headers.reload.inspect
    # puts "MADE IT"
    # # order = 1
    # # 4.times do
    # #   Feeling.create!(body: Faker::Hacker.say_something_smart, user_id: @user.id, page_order: order)
    # #   order += 1
    # # end
    @user = User.create(email: 'jim@home.com', first_name: 'Jim', last_name: 'Pub', password: 'password')
    @headers = valid_headers(@user.id).except('Authorization')
    @valid_creds = { email: @user.email, password: @user.password }.to_json
    post auth_login_path, headers: @headers, params: @valid_creds
    @headers['Authorization'] = json['auth_token']

  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
