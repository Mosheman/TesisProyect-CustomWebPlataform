class ApiMarkersController < BaseApiController


  def push_markers
    render json: @project
  end

end
