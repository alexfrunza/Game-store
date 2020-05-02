class Order < ApplicationRecord
  has_one :game
  has_one :user
end
