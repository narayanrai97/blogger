class ArticlesController < ApplicationController
include ArticlesHelper   # Strong Parameters

  before_action :require_login, except: [:index, :show]
  impressionist :actions=>[:show]

  def index
    # @articles = Article.pluck(:id)
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
  end
  
  def show
    # @category = Category.find(params[:id])
    @article = Article.find(params[:id])
    
    @comment = Comment.new
    @comment.article_id = @article.id
    
    # @category.id = @article.category_id
    # impressionist
    impressionist(@article)
  end
  
  def new
    @article = Article.new
    @tag = Tag.new
    @tagging = Tagging.new
    # @category = Category.find(params[:id])
    
    @tagging.article_id = @article.id # association
    @tagging.tag_id = @tag.id        # association

    # @author = current_user
    # @article.author_id = @author.id
  end
  
  def create 
    @article = current_user.articles.new(article_params)
    if @article.save
      flash.notice = "Article '#{@article.title}' has been created!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    
    # restricting articles to being destroyed only by their original owner
    if current_user.id == @article.author_id
      @article.destroy
        flash.notice = "Article '#{@article.title}' has been deleted!"
        redirect_to articles_path
    else
      redirect_to(@article, notice: "Sorry, you cannot delete this Article!")
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  
    # adding my extra credit here to restrict "edit" to only its owner
    unless current_user.id == @article.author_id
       redirect_to(@article, notice: "Sorry, you cannot edit this Article!") and return
    end
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    
      flash.notice = "Article '#{@article.title}' updated!"
      redirect_to article_path(@article)
  end
end
