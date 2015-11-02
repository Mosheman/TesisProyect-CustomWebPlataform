class DashboardController < ApplicationController
  def index
  	@count = current_user.data_count
  	@searches = []
  end
end
