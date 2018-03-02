class CommentsController < ApplicationController
    include CommentsHelper   # Strong Parameters
    
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new(comment_params)
        
        @comment.save
            flash.notice = "#{@comment.author_name} commented on the article '#{@article.title}'!"
            redirect_to article_path(@comment.article) 
    end
end
