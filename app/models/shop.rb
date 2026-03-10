class Shop < ApplicationRecord
  has_many :reviews, dependent: :destroy

  scope :mappable, -> { where.not(lat: nil, lng: nil) }
end
