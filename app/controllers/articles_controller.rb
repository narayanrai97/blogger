class ArticlesController < ApplicationController
include ArticlesHelper   # Strong Parameters

  before_action :require_login, except: [:index, :show]
  impressionist :actions=>[:show]

  def index
    @articles = Article.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @article = Article.find(params[:id])
    
    @comment = Comment.new
    
    ## association
    @comment.article_id = @article.id
    
    impressionist(@article)
  end
  
  def new
    @article = Article.new
    @tag = Tag.new
    @tagging = Tagging.new

    ## association
    @tagging.article_id = @article.id 
    @tagging.tag_id = @tag.id        
  end
  
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash.notice = "Article #{@article.title} has been created!"
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
  
    # restricting articles to being updated only by their original owner
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
