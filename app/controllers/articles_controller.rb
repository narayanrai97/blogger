class ArticlesController < ApplicationController
include ArticlesHelper   # Strong Parameters

  def index
    @articles = Article.all
    
    @count2 = @articles.count
  end
  
  def show
    @article = Article.find(params[:id])
    
    @comment = Comment.new
    @comment.article_id = @article.id
    
    @count = @article.comments.size
  end
  
  def new
    @article = Article.new
    @tag = Tag.new
    
    @tagging = Tagging.new
    @tagging.article_id = @article.id # association
    @tagging.tag_id = @tag.id        # association
  end
  
  def create 
    @article = Article.new(article_params)
    @article.save
    # @tag = Tag.new
    # @tag.save
      flash.notice = "Article '#{@article.title}' has been created!"
      redirect_to article_path(@article)
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
      flash.notice = "Article '#{@article.title}' has been deleted!"
      redirect_to articles_path
  end
  
  def edit
    @article = Article.find(params[:id])
    # @tag = Tag.find(params[:article_id])
    # @tagging = Tag.find(params[:article_id])
    # @tagging.tag_id = @tag.id
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    
      flash.notice = "Article '#{@article.title}' has been updated!"
      redirect_to article_path(@article)
  end
  
end
