class User < ApplicationRecord
  has_secure_password

  has_many :grids, dependent: :delete_all

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
