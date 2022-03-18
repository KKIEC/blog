class SearchController < ApplicationController
  def index
    @articles = Article.search(params[:search])
    @categories = Category.search(params[:search])
    @users = User.search(params[:search])
  end
end
