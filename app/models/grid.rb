class Grid < ApplicationRecord
  belongs_to :user
  enum status: [:playing, :game_over, :game_won]

  belongs_to :user, optional: true
  has_many :squares, dependent: :delete_all

  validates :width, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :height, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :number_of_mines, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: :squares_count }

  before_create :default_status
  after_create :build_squares

  private

  def squares_count
    width * height
  end

  def default_status
    self.status = Grid::statuses[:playing]
  end

  def build_squares
    width.times do |x|
      height.times do |y|
        squares.create x: x, y: y
      end
    end
    # randomly get number_of_mines number of squares and turn them a mine
    squares.sample(number_of_mines).each { |square| square.turn_mine! }
  end
end
