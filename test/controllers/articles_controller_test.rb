require 'test_helper'

class ArtcilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = User.create(
      username: 'test',
      email: 'test@example.com',
      password: 'xxxxxxxx',
      admin: false
    )
    @article = Article.create(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 10),
      user: @author,
      premium: false
    )
    @premium_article = Article.create(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 10),
      user: @author,
      premium: true
    )
    @user = User.create(
      username: 'test2',
      email: 'test2@example.com',
      password: 'xxxxxxxx',
      admin: false
    )
    @admin_user = User.create(
      username: 'johndoe',
      email: 'johndoe@example.com',
      password: 'password',
      admin: true
    )
    @article_valid_params = {
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 10)
    }
  end

  test 'should show free article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should not show premium article without login' do
    get article_url(@premium_article)
    assert_redirected_to articles_url
  end

  test 'should not show premium article with login and without active subscription' do
    sign_in_as(@user)
    get article_url(@premium_article)
    assert_redirected_to articles_url
  end

  test 'should show premium article with active subscription' do
    sign_in_as(@user)
    @user.update(subscription_status: 'active')
    get article_url(@premium_article)
    assert_response :success
  end

  test 'should show own article without subscription' do
    sign_in_as(@author)
    get article_url(@premium_article)
    assert_response :success
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
  end

  test 'should get edit when admin' do
    sign_in_as(@admin_user)
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should get edit when author' do
    sign_in_as(@author)
    get edit_article_url(@premium_article)
    assert_response :success
  end

  test 'should not get edit if not admin or author' do
    sign_in_as(@user)
    get edit_article_url(@article)
    assert_redirected_to article_url(@article)
  end

  test 'should create article' do
    sign_in_as(@user)
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: @article_valid_params }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should not create article if not login' do
    assert_no_difference('Article.count') do
      post articles_url, params: @article_valid_params
    end

    assert_redirected_to login_url
  end

  test 'should update article when admin' do
    sign_in_as(@admin_user)
    patch article_url(@article), params: { article: @article_valid_params }
    assert_redirected_to article_url(@article)
    assert Article.where(@article_valid_params).any?
  end

  test 'should update article when author' do
    sign_in_as(@author)
    patch article_url(@article), params: { article: @article_valid_params }
    assert_redirected_to article_url(@article)
    assert Article.where(@article_valid_params).any?
  end

  test 'should not update category if not admin or author' do
    sign_in_as(@user)
    patch article_url(@article), params: { article: @article_valid_params }
    assert_not Article.where(@article_valid_params).any?
  end

  test 'should destroy article when admin' do
    sign_in_as(@admin_user)
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test 'should destroy article when author' do
    sign_in_as(@author)
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test 'should not destroy category if not admin or author' do
    sign_in_as(@user)
    assert_no_difference('Article.count') do
      delete article_url(@article)
    end
  end
end
