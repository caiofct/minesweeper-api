class SquaresController < ApplicationController
  def index
    render json: @current_user.grids.find(params[:grid_id]).squares
  end

  def toggle_flag
    square = get_square
    if square.toggle_flag!
      render json: square
    else
      head :unprocessable_entity
    end
  end

  def explore
    square = get_square
    traversed = square.explore!
    render json: traversed
  end

  private

  def get_square
    filtered_params = params.permit(:x, :y)
    @current_user.grids.find(params[:grid_id]).squares.find_by_x_and_y filtered_params[:x], filtered_params[:y]
  end
end
