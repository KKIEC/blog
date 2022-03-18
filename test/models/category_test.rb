require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'Sports')
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test 'name should be present' do
    @category.name = ' '
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    @category2 = Category.new(name: 'Sports')
    assert_not @category2.valid?
  end

  test 'name should not be too long' do
    @category.name = 'a' * 26
    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = 'aa'
    assert_not @category.valid?
  end

  test 'search should return only category2' do
    @category.save
    @category2 = Category.create(name: 'AAbbCC')
    categories = Category.search('aBBc')
    assert_equal( @category2, categories.first)
    assert_equal( 1, categories.count)
  end
end
