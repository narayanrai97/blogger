class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  protect_from_forgery with: :exception
  # before_action :require_login

  # def require_login
  #   unless logged_in?
  #     flash.now.alert = "You must be logged in to access this section"
  #     redirect_to login_url # halts request cycle
  #   end
  # end
end
