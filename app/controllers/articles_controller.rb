class ArticlesController < ApplicationController
  def index
    if params[:query].present?
      @articles = Article.search_by_title_and_body("#{params[:query]}")
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end
end
