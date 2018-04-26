class StaticPagesController < ApplicationController
  def home
    # @articles = Article.order(created_at: :desc)
    # @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
