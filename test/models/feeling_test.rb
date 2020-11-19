require 'test_helper'

class FeelingTest < ActiveSupport::TestCase
  test 'should know its user' do
    feeling = feelings(:one)
    user = User.find(feeling.user_id)
    assert user
  end
end
