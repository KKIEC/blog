require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      username: 'test',
      email: 'test@example.com',
      password: 'xxxxxxxx',
      admin: false
    )
  end

  test 'should get new' do
    get login_url
    assert_response :success
  end

  test 'should assign session for correct credentials' do
    sign_in_as(@user)
    assert_equal(@user.id, session[:user_id])
  end

  test 'should not assign session for incorrect credentials' do
    post login_path, params: { session: { email: 'notexisting@example.com', password: 'xxxxxxxx' } }
    assert_nil session[:user_id]
  end

  test 'should destroy session when logout' do
    sign_in_as(@user)
    delete logout_url
    assert_nil session[:user_id]
    assert_redirected_to root_url
  end
end
