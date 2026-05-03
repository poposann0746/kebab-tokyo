class Shop < ApplicationRecord
  has_many :reviews, dependent: :destroy

  scope :mappable, -> { where.not(lat: nil, lng: nil) }

  scope :search, ->(query) {
    next all if query.blank?
    pattern = "%#{sanitize_sql_like(query.strip)}%"
    where("name ILIKE :q OR address ILIKE :q OR area ILIKE :q", q: pattern)
  }
end
