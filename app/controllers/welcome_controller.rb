class WelcomeController < ApplicationController
  before_filter :check_user_loged_in

  def index
  end
  
  def contact
  end
  
  def about  	
  end

  def check_user_loged_in
  	if user_signed_in?
  		redirect_to dashboard_index_path
  	end
  end

end
