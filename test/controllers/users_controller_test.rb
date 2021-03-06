require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_params = {
      email: 'jim@home.com',
      first_name: 'Jim',
      last_name: 'Pub',
      password: 'password',
      password_confirmation: 'password'
    }.to_json
    @headers = { "Content-Type" => "application/json" }
    @validation_message = "Validation failed: Password can't be blank, First name can't be blank,"\
                          "Last name can't be blank, Email can't be blank,"\
                          "Password digest can't be blank"
  end

  test 'user can sign up with valid request' do
    post signup_path, headers: @headers, params: @user_params
    assert_response :created
    assert_match json['message'], Message.account_created
    refute_nil json['auth_token']
  end

  test 'user cannot sign up with invalid request' do
    post signup_path, headers: @headers, params: {}
    assert json['message'].include?("Validation failed")
  end
end
