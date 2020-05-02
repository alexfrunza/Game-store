class Game < ApplicationRecord

  validates_presence_of :title, :message => "Title can't be blank"
  validates_presence_of :about, :message => "About can't be blank"
  validates_presence_of :release_date, :message => "Release date can't be blank"
  validates_presence_of :game_types, :message => "You must select a genre"
  validates_presence_of :developer_id, :message => "You must select a developer"
  validates_presence_of :franchise_id, :message => "You must select a franchise"
  validates_presence_of :platform_id, :message => "You must select a platform"
  validates_presence_of :rarity_id, :message => "You must select a rarity"
  validates_presence_of :stock, :message => "You must insert a stock"
  validates_format_of :stock, with: /\A[1-9]\d*\Z/, :message => "You must insert a positive integer in stock field"

  belongs_to :rarity
  belongs_to :developer
  belongs_to :franchise
  belongs_to :platform
  has_and_belongs_to_many :game_types

end
