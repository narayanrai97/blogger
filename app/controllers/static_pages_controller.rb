class StaticPagesController < ApplicationController
  def home
    @message = Message.posted_messages.order(updated_at: :desc).first
  end

  def help
  end

  def about
  end

  def contact
  end

  def profile
  end
end
