class DraftController < ApplicationController
  def index
    @articles = Article.all
  end
end