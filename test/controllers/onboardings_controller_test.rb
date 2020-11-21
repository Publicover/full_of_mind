require 'test_helper'

class OnboardingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: 'jim@home.com', first_name: 'Jim', last_name: 'Pub', password: 'password')
    @headers = {
      "Authorization"=>"#{token_generator(@user.id)}"
    }
    @valid_creds = { email: @user.email, password: @user.password }.to_json
    post auth_login_path, headers: @headers, params: @valid_creds
  end

  test 'should create 4 feelings and flip user.onboarding' do
    post user_onboardings_path(@user.id), headers: @headers,
                               params: { feeling: { body: 'test this', user_id: @user.id } }
    assert_response :success
    refute @user.reload.onboarding_complete

    post user_onboardings_path(@user.id), headers: @headers,
                               params: { feeling: { body: 'test that', user_id: @user.id } }
    assert_response :success
    refute @user.reload.onboarding_complete

    post user_onboardings_path(@user.id), headers: @headers,
                               params: { feeling: { body: 'test all this', user_id: @user.id } }
    assert_response :success
    refute @user.reload.onboarding_complete

    post user_onboardings_path(@user.id), headers: @headers,
                               params: { feeling: { body: 'test all that', user_id: @user.id } }
    assert_response :success
    assert @user.reload.onboarding_complete
  end

  test 'cannot create feelings if onboarding is not complete' do
    post user_feelings_path(@user), headers: @headers,
                                    params: { feeling: { body: 'this should fail', user_id: @user.id } }
    assert_match json['message'], "ExceptionHandler::AuthenticationError"
  end
end
