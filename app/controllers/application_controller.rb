class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_current_location, :unless => :devise_controller?
  before_filter :set_twitter_client

  def after_sign_in_path_for(resource)
    stored_location_for(:superuser) ? stored_location_for(:superuser) : dashboard_index_path
  end

  def store_current_location
    stored_location_for(:user)
  end

  def set_twitter_client
    if current_user
      if current_user.has_credentials
        @current_client = Twitter::REST::Client.new do |config|
          config.consumer_key        = current_user.twitter_credential.consumer_key
          config.consumer_secret     = current_user.twitter_credential.consumer_secret
          config.access_token        = current_user.twitter_credential.access_token
          config.access_token_secret = current_user.twitter_credential.access_token_secret
        end  
      end
    end    
  end

end
