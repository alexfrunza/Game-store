class Franchise < ApplicationRecord
  has_many :games, dependent: :destroy
end
