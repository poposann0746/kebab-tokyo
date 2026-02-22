class ShopsController < ApplicationController
  before_action :authenticate_user!, only: [ :select ]

  def index
    @shops = Shop.order(created_at: :desc)
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def select
    @shops_by_area = Shop.where.not(area: nil).order(:name).group_by(&:area)
  end
end
