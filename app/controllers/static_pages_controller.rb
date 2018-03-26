class StaticPagesController < ApplicationController
  def home
    @articles = Article.all
    flash.notice = 'LOGGED IN SUCCESSFUL'
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
