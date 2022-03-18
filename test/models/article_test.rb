require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: 'testuser',
      email: 'test@example.com',
      password: 'xxxxxxxx',
      admin: true
    )
    @article = Article.new(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 10),
      user: @user,
      premium: [true, false].sample
    )
  end

  test 'article should be valid' do
    assert @article.valid?
  end

  test 'title should be present' do
    @article.title = ' '
    assert_not @article.valid?
  end

  test 'description should be present' do
    @article.description = ' '
    assert_not @article.valid?
  end

  test 'title should not be too long' do
    @article.title = 'a' * 101
    assert_not @article.valid?
  end

  test 'title should not be too short' do
    @article.title = 'aaaaa'
    assert_not @article.valid?
  end

  test 'description should not be too long' do
    @article.description = 'a' * 301
    assert_not @article.valid?
  end

  test 'description should not be too short' do
    @article.description = 'a' * 9
    assert_not @article.valid?
  end

  test 'to_s should be ovveriden and refer to article title' do
    assert_equal(@article.title, @article.to_s)
  end

  test 'search should return only article2' do
    @article.save
    @article2 = Article.create(
      title: 'AAbbCC',
      description: Faker::Lorem.paragraph(sentence_count: 10),
      user: @user,
      premium: [true, false].sample
    )
    articles = Article.search('aBBc')
    assert_equal( @article2, articles.first)
    assert_equal( 1, articles.count)
  end
end
