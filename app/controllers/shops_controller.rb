class ShopsController < ApplicationController
  before_action :authenticate_user!, only: [ :select, :map ]

  def index
    @shops = Shop.order(created_at: :desc)
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def select
    @shops_by_area = Shop.where.not(area: nil).order(:name).group_by(&:area)
  end

  def map
    shops = Shop.mappable.includes(:reviews)
    @shops_json = shops.map { |shop|
      {
        id: shop.id,
        name: shop.name,
        area: shop.area,
        address: shop.address,
        lat: shop.lat,
        lng: shop.lng,
        image_url: shop.image_url1,
        avg_score: shop.reviews.average(:overall_score)&.round(1),
        review_count: shop.reviews.size
      }
    }.to_json
    @google_maps_api_key = Rails.application.credentials.dig(:google_maps, :api_key)
    @google_maps_map_id = Rails.application.credentials.dig(:google_maps, :map_id)
  end
end
