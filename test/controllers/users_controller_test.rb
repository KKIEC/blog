require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      username: 'test',
      email: 'test@example.com',
      password: 'xxxxxxxx',
      admin: false
    )
    @admin_user = User.create(
      username: 'johndoe',
      email: 'johndoe@example.com',
      password: 'password',
      admin: true
    )
    @user_valid_params = {
      username: 'Modified',
      email: 'modified@example.com',
      password: 'xxxxxxxx'
    }
  end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new for signup' do
    get signup_url
    assert_response :success
  end

  test 'should get edit when admin' do
    sign_in_as(@admin_user)
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should get edit own account' do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should not get edit if not admin or owner' do
    sign_in_as(@user)
    get edit_user_url(@admin_user)
    assert_redirected_to user_url(@admin_user)
  end

  test 'should update user when admin' do
    sign_in_as(@admin_user)
    patch user_url(@user), params: { user: @user_valid_params }
    assert_redirected_to user_url(@user)
    assert User.where(username: @user_valid_params[:username]).any?
  end

  test 'should update own account' do
    sign_in_as(@user)
    patch user_url(@user), params: { user: @user_valid_params }
    assert_redirected_to user_url(@user)
    assert User.where(username: @user_valid_params[:username]).any?
  end

  test 'should not update user if not admin or owner' do
    sign_in_as(@user)
    patch user_url(@admin_user), params: { user: @user_valid_params }
    assert_not User.where(username: @user_valid_params[:username]).any?
  end

  test 'should create user' do
    assert_difference('User.count', 1) do
      post users_url, params: { user: @user_valid_params }
    end

    assert_redirected_to articles_url
  end

  test 'should destroy user when admin' do
    sign_in_as(@admin_user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to articles_url
  end

  test 'should destroy own user account' do
    sign_in_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to articles_url
  end

  test 'should not destroy user if not admin or owner' do
    sign_in_as(@user)
    assert_no_difference('User.count') do
      delete user_url(@admin_user)
    end
  end
end
