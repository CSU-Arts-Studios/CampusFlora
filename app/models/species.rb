class Species < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  after_save :expire_cache

  belongs_to :family
  has_many :species_locations

  has_many :species_trails
  has_many :trails, through: :species_trails, :class_name => 'Trail'

  has_many :images

  accepts_nested_attributes_for :family
  accepts_nested_attributes_for :species_locations, :allow_destroy => true
  accepts_nested_attributes_for :species_trails
  accepts_nested_attributes_for :images, :allow_destroy => true

  def html_link_description
    auto_link(self.description)
  end

  # When we update or create a new species, expire the front end cache for the species objects
  def expire_cache
    expire_fragment('map_index_json')
  end
end