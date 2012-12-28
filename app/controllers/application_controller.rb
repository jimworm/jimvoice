class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate!
  
  def current_user
    @current_user
  end
  helper_method :current_user
  
  private
  def authenticate!
    if Rails.env.development?
      @current_user = User.new name: 'Development mode'
      return true
    end
    
    authenticate_or_request_with_http_basic('Log in with your password in your encrypted password file') do |username, password|
      user = User.find_by_name(username)
      @current_user = user if user.try(:authenticate, password)
    end
  end
end
