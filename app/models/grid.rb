class Grid < ApplicationRecord
  belongs_to :user
  enum status: [:playing, :game_over]

  belongs_to :user, optional: true

  validates :width, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :height, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
