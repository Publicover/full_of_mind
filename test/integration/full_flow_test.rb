# frozen_string_literal: true

require 'test_helper'

class FullFlowTest < ActionDispatch::IntegrationTest
  test 'should be no breaks in flow' do
    # user creates an account
    assert_difference('User.count') do
      post signup_path, params: signup_params
    end
    assert_response :created

    # user id is included in response for login and signup
    assert_not_nil json['user']

    # grab the new user information and set the headers
    @user = User.last
    @headers = {
      "Content-Type"=>"application/json",
      "Accept"=>"application/json",
      "Authorization"=>"#{response.body['auth_token']}"
    }
    @login_headers = @headers.except("Content-Type", "Accept")

    # we already have a test that shows the jwt expiring,
      # so we don't need to handle that here

    # user goes through onboarding
      # user inputs first four feelings
      # user is told how app works
    # user cannot add more than one feeling per day
      # is this a background job?

    # next day, user is asked to add another feeling
    # puts @user.inspect
    post auth_login_path, headers: @login_headers, params: login_params
    assert_response :success

    # next day, user is asked to pick a feeling to remove
    # post user_feeling_path()
    # next day, one feeling is demoted and four remain
    # user can see most persistent feeling
    # user can see least persistent feeling


  end

  def signup_params
    { email: 'test@jim.com', first_name: 'jim', last_name: 'pub', password: 'test' }
  end

  def login_params
    signup_params.except('first_name', 'last_name')
  end
end
