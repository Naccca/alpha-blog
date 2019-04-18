require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  test 'attempt to signup with invalid details' do
    assert_no_difference 'User.count' do
      post(users_path, params: { user: { username: 'john', email: 'invalid', password: 'password' } })
    end
  end

  test 'attempt to signup with existing user details' do
    user = User.create!(username: 'john', email: 'john@mail.com', password: 'password')
    assert_no_difference 'User.count' do
      post(users_path, params: { user: { username: user.username, email: user.email, password: 'password' } })
    end
  end

  test 'register as new user' do
    assert_difference 'User.count', 1 do
      post(users_path, params: { user: { username: 'john', email: 'john@mail.com', password: 'password' } })
    end
    user = User.find_by!(username: 'john')
    assert_equal('john@mail.com', user.email)
  end
end
