class ApiNodesController < BaseApiController


  def push_nodes
    render json: @project
  end

end
