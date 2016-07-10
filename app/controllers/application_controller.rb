class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_current_location, :unless => :devise_controller?
  # before_filter :set_twitter_client

  def after_sign_in_path_for(resource)
    stored_location_for(:superuser) ? stored_location_for(:superuser) : dashboard_index_path
  end

  def store_current_location
    stored_location_for(:user)
  end

end
