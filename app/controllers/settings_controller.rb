class SettingsController < ApplicationController
  def index
  	# Checks if user has a twitter_credential
  	credential = current_user.twitter_credential
  	if credential 	# If exist credetial for a given user -> render as edit
  		@twitter_credential = credential
  	else			# If there is no credential for a given user -> render as new
  		current_user.twitter_credential = TwitterCredential.new
  		@twitter_credential = current_user.twitter_credential
  	end
  end
end
