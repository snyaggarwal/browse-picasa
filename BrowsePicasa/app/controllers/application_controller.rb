class ApplicationController < ActionController::Base
  protect_from_forgery


  private
  def current_user
    @current_user ||= User.new(session[:access_token])
  end

  helper_method :current_user
end
