class CommentsController < ApplicationController
    include CommentsHelper   # Strong Parameters
    
    def create
        # did this for purpose of flash message below
        @article = Article.find(params[:article_id]) 
        
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]
        
        @comment.save
            flash.notice = "#{@comment.author_name} commented on the article '#{@article.title}'!"
            redirect_to article_path(@comment.article) 
    end
end
