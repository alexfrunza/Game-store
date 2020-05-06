class Game < ApplicationRecord

  validates_presence_of :title, :base => "Title can't be blank"
  validates_presence_of :about, :base => "About can't be blank"
  validates_presence_of :release_date, :base=> "Release date can't be blank"
  validates_presence_of :game_types, :base => "You must select a genre"
  validates_presence_of :developer_id, :base => "You must select a developer"
  validates_presence_of :franchise_id, :base => "You must select a franchise"
  validates_presence_of :platform_id, :base => "You must select a platform"
  validates_presence_of :rarity_id, :base => "You must select a rarity"
  validates_presence_of :stock, :base => "You must insert a stock"
  validates_format_of :stock, with: /\A[0-9]\d*\Z/, :base => "You must insert a positive integer in stock field"
  validates_presence_of :photo_url, :base => "Photo url can't be blank"
  validates_presence_of :video_url, :base => "Video url can't be blank"

  acts_as_taggable

  belongs_to :rarity
  belongs_to :developer
  belongs_to :franchise
  belongs_to :platform
  has_and_belongs_to_many :game_types

end
