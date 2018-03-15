class CommentsController < ApplicationController
    # include CommentsHelper   # Strong Parameters
    
    before_action :require_login, except: [:create] # Just incase if we implement "index" or "destroy"
    
    # def index
    #     @comments = Comment.all
    # end
    
    def new
        @comment = Comment.new
    end
    
    def edit
        @comment = Comment.find(params[:id])
    end
    
    def create
        # did this for purpose of displaying flash message below
        @article = Article.find_by(params[:id]) 
        
        @comment = @article.comments.new(comment_params)
        # @comment.article_id = params[:article_id]
        
        if @comment.save
            flash.notice = "#{@comment.author_name} commented on the article '#{@article.title}'!"
            redirect_to article_path(@comment.article) 
        else
            flash.notice = "Sorry, the fields cannot be blank!"
            redirect_to article_path(@article)
        end
    end
    
    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
            flash.notice = "Comment deleted!"
            redirect_to article_path(@article)
    end
    
    private
    
    def comment_params
        params.require(:comment)
              .permit(:author_name, :body)
    end
end
