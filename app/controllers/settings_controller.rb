class SettingsController < ApplicationController
  def index
  	# Checks if user has a twitter_credential
  	credential = TwitterCredential.where(user_id: current_user.id).first
  	if credential
  		@twitter_credential = credential
  	else
  		@twitter_credential = TwitterCredential.new
  	end
  end
end
