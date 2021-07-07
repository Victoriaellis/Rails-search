require 'open-uri'
require 'nokogiri'

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

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    html_file = URI.open(@article.url).read
    html_doc = Nokogiri::HTML(html_file)
    @article.body = html_doc.search('h1').text + "," + html_doc.search('h2').text + "," + html_doc.search('h3').text
    html_doc.search('article').each do |element|
      wpm = 225
      words = element.text.split(/\s+/).length
      @article.reading_time = (words / wpm).to_s
    end
    @article.short_url = (@article.url.match(/^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/))[3]
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :url)
  end
end
