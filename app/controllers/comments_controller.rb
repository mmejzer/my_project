# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to article_path(@article), notice: 'Your comment was posted'
    else
      redirect_to article_path(@article), alert: "Error! Comment can't be create"
    end
  end

  def edit;
  end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article), notice: 'Your comment was edited'
    else
      render :edit, alert: "Error! Comment can't be edit"
    end
  end

  def destroy
    if @comment.destroy
      redirect_to article_path(@article), status: :see_other, notice: 'Comment deleted!'
    else
      redirect_to article_path(@article), alert: "Error! Comment can't be delete"
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :article_id, :user_id)
  end
end
