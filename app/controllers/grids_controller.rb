class GridsController < ApplicationController
  def index
    render json: current_user.grids.order('created_at desc')
  end
end
