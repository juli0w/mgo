class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_company

  def create
    comment = @article.comments.create(comment_params)
    if comment
      comment.update(user: current_user)
      flash[:notice] = "Agradecemos seu comentário!"
    else
      flash[:notice] = "Seu comentário não foi enviado, verifique os campos e tente novamente"
    end

    redirect_to "/#{@company.slug}/#{@page.slug}/#{@article.slug}"
  end

  def destroy
    comment = @article.comments.find(params[:id])
    if comment.owner? current_user
      comment.destroy
    end

    redirect_to "/#{@company.slug}/#{@page.slug}/#{@article.slug}"
  end

private

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

  def set_company
    @company = Company.find(params[:slug])
    @page = @company.profile.pages.find(params[:paging])
    @article = @company.articles.find(params[:article])
  end
end
