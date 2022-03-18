require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: 'testuser',
      email: 'test@example.com',
      password: 'xxxxxxxx'
    )
  end

  test 'should store in db lower cased emails' do
    @user.email = 'Test@Example.com'
    @user.save
    assert_equal('test@example.com', @user.email)
  end

  test 'username should be present' do
    @user.username = ' '
    assert_not @user.valid?
  end

  test 'username should be uniqueness and case insensitive' do
    @user.save
    @user2 = User.new(
      username: @user.username.upcase,
      email: 'test2@example.com',
      password: 'xxxxxxxx'
    )
    assert_not @user2.valid?
  end

  test 'username should not be too long' do
    @user.username = 'a' * 26
    assert_not @user.valid?
  end

  test 'username should not be too short' do
    @user.username = 'aa'
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'email should be uniqueness and case insensitive' do
    @user.save
    @user2 = User.new(
      username: 'test2user',
      email: 'Test@Example.com',
      password: 'xxxxxxxx'
    )
    assert_not @user2.valid?
  end

  test 'email should not be too long' do
    @user.email = 'example@' + ('a' * 106) + '.com'
    assert_not @user.valid?
  end

  test 'should be in accordance with REGEX' do
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    assert_match(VALID_EMAIL_REGEX , @user.email)
  end

  test 'to_s should be ovveriden and refer to user email' do
    assert_equal(@user.email, @user.to_s)
  end

  test 'search should return only user2' do
    @user.save
    @user2 = User.create(
      username: 'AAbbCC',
      email: 'test2@example.com',
      password: 'xxxxxxxx'
    )
    users = User.search('aBBc')
    assert_equal( @user2, users.first)
    assert_equal( 1, users.count)
  end
end
