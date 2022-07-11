class HomeController < ApplicationController
  def index
    @articles = Article.where(status: 'public')
  end
end
