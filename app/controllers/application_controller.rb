class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :is_signed_in?, :current_user_image

  before_filter :load_pages_for_the_links

  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id], :include => :ideas)
  end

  def is_signed_in?
    !!current_user
  end

  def current_user_image
    session[:user_image] || "no-picture.jpg"
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end


  def load_pages_for_the_links
    @pages_for_links = Page.order('title ASC').select(['title', 'slug'])
  end
end
