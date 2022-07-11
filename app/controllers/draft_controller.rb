class DraftController < ApplicationController
  def index
    @articles = Article.where(status: 'draft')
  end
end