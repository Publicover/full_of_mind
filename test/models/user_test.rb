require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should validate email' do
    user = User.new(first_name: 'test', last_name: 'test', password: 'hey-testing')
    assert_not user.save
    assert_not_nil user.errors[:email]
  end

  test 'should validate first_name' do
    user = User.new(email: 'test@test.com', last_name: 'test', password: 'hey-testing')
    assert_not user.save
    assert_not_nil user.errors[:first_name]
  end

  test 'should validate last_name' do
    user = User.new(email: 'test@test.com', first_name: 'test', password: 'hey-testing')
    assert_not user.save
    assert_not_nil user.errors[:last_name]
  end

  test 'should check current total' do
    user = User.create!(email: 'jim@test.com', first_name: 'test', last_name: 'test', password: 'hey-testing')
    page_order_count = 1
    5.times do
      user.feelings.create!(body: 'testing here', page_order: page_order_count, persistent: :current)
      page_order_count += 1 unless page_order_count > 3
    end
    assert user.check_current_total == 5
  end
end
