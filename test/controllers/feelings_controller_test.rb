require 'test_helper'

class FeelingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: 'jim@home.com', first_name: 'Jim', last_name: 'Pub', password: 'password', onboarding_complete: true)
    @headers = {
      "Content-Type"=>"application/json",
      "Accept"=>"application/json",
      "Authorization"=>"#{token_generator(@user.id)}"
    }
    @valid_creds = { email: @user.email, password: @user.password }.to_json
    post auth_login_path, headers: @headers, params: @valid_creds

    order = 1
    4.times do
      Feeling.create!(body: Faker::Hacker.say_something_smart, user_id: @user.id, page_order: order)
      order += 1
    end
  end

  test 'fixtures should work' do
    assert_not_nil @user.feelings
    assert 4, @user.feelings.count
  end

  test "should get index" do
    get user_feelings_path(@user), headers: @headers
    assert_response :success
  end

  test "should get show" do
    get user_feeling_path(@user, @user.feelings.first), headers: @headers
    assert_response :success
  end

  test "should get create" do
    post user_feelings_path(@user),
         headers: @headers.except("Content-Type", "Accept"),
         params: { "feeling"=>{ "body"=>"this", "user_id"=>"#{@user.id}" } }
    assert_response :success
  end

  test "should get destroy" do
    get user_feeling_path(@user, @user.feelings.first), headers: @headers
    assert_response :success
  end

  test "new feeling should persist" do
    assert @user.feelings.last.current?
  end

  test "old feeling should not persist" do
    order_num = 1
    5.times do
      @user.feelings.create!(
        body: Faker::Games::Witcher.quote, user_id: @user.id, page_order: order_num
      )
      order_num += 1
    end

  end

end
