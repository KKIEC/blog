require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      username: 'test',
      email: 'test@example.com',
      password: 'xxxxxxxx',
      admin: false
    )
  end

  test 'home should redirect to articles listing when login' do
    sign_in_as(@user)
    get root_path
    assert_redirected_to articles_url
  end

  test 'home should get home when logout' do
    get root_path
    assert_response :success
  end
end
