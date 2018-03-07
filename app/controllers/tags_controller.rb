class TagsController < ApplicationController
    def index
        @tags = Tag.all
        @tags_total = @tags.count
    end
    
    def show
        @tag = Tag.find(params[:id])
        
        # for the purpose of displaying number of related articles
        @articles = @tag.articles
        @count3 = @articles.count
    end
    
    def destroy
        @tag = Tag.find(params[:id])
        @tag.destroy
            flash.notice = "The Tag has been deleted!"
            redirect_to tags_path
    end
end
