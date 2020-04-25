class Game < ApplicationRecord
  belongs_to :developer
  belongs_to :franchise
  belongs_to :platform
  has_and_belongs_to_many :game_types
end
