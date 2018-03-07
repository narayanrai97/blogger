class CommentsController < ApplicationController
    include CommentsHelper   # Strong Parameters
    
    def index
        @comments = Comment.all
    end
    
    def new
        @comment = Comment.new
    end
    
    def edit
        @comment = Comment.find(params[:id])
    end
    
    def create
        # did this for purpose of displaying flash message below
        @article = Article.find(params[:article_id]) 
        
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]
        
        @comment.save
            flash.notice = "#{@comment.author_name} commented on the article '#{@article.title}'!"
            redirect_to article_path(@comment.article) 
    end
    
    def destroy
        @article = Article.find(params[:id])
        @comment = Comment.find(params[:id])
        @comment.destroy
            redirect_to article_path(@article)
    end
end
