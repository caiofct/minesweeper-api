class Square < ApplicationRecord
  belongs_to :grid

  validates :x, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: :grid_width }
  validates :y, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: :grid_height }

  def grid_width
    grid.width
  end

  def grid_height
    grid.height
  end

  def adjacents(include_mines = false)
    conditions = [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1], [x - 1, y], [x + 1, y], [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]].map { |coord|
      "(x = #{coord[0]} AND y = #{coord[1]})" if coord[0] >= 0 && coord[1] >= 0 && coord[0] < grid.width && coord[1] < grid.height
    }.compact.join ' OR '
    squares = Square.where(conditions).where(grid_id: grid_id)
    squares = squares.where(mine: false) if !include_mines
    squares
  end

  def turn_mine!
    return if mine
    adjacents.update_all('mines = mines + 1')
    update_attributes mine: true, mines: -1
  end

  def toggle_flag!
    attribute_updated = update_attribute(:flagged, !flagged)
    all_flagged = true
    # setting the game as won when all mines have been flagged
    grid.squares.where(mine: true).each do |mine_square|
      all_flagged = false if !mine_square.flagged?
    end
    grid.game_won! if all_flagged
    attribute_updated
  end

  def explore!
    return if explored
    update_attribute :explored, true
    traversed = [self]
    if mine
      # setting the game as over when a mine is explored
      grid.game_over!
    else
      if mines <= 0
        traversed += explore_adjacents(adjacents)
      end
    end
    traversed
  end

  private

  def explore_adjacents adjacents
    traversed = []
    adjacents.each do |square|
      unless square.explored
        square.update_attribute :explored, true
        traversed << square
        if square.mines <= 0
          traversed += explore_adjacents(square.adjacents)
        end
      end
    end
    traversed
  end
end
