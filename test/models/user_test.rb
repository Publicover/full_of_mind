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
end
