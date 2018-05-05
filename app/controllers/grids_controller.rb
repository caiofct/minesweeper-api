class GridsController < ApplicationController
  def index
    render json: current_user.grids.order('created_at desc')
  end

  def create
    grid = Grid.new(grid_params)
    grid.user = current_user
    grid.status = Grid::statuses[:playing]
    if grid.save
      head :created
    else
      render json: grid.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    error = false
    error_message = nil
    begin
      grid = current_user.grids.find(params[:id])
      grid.destroy
    rescue => ex
      error = true
      error_message = ex.message
    end

    if !error
      head :ok
    else
      render json: error_message, status: :unprocessable_entity
    end
  end

  private

  def grid_params
    params.require(:grid).permit(:width, :height, :number_of_mines)
  end
end
