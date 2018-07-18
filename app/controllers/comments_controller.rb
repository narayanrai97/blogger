class CommentsController < ApplicationController
    # include CommentsHelper   # Strong Parameters
    
    before_action :require_login, except: [:create] # Just incase if we implement "index" 
    
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
        @article = Article.find(params[:article_id])
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]
        
        if @comment.save
            flash.notice = "#{@comment.commenter} commented on the article #{@article.title}!"
            redirect_to article_path(@comment.article) 
        else
            flash.notice = "Sorry, the comment couldn't be created!"
            redirect_to article_path(@comment.article)
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
            params.require(:comment).permit(:commenter, :content)
        end
end
