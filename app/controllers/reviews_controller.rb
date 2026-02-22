class ReviewsController < ApplicationController
  before_action :set_shop
  before_action :authenticate_user!

  def new
    @review = @shop.reviews.build
  end

  def create
    @review = @shop.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @shop, notice: "レビューを投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def review_params
    params.require(:review).permit(
      :category,
      :meat_type,
      :sauce_type,
      :meat_taste,
      :sauce_taste,
      :vegetable_amount,
      :bread_compatibility,
      :value_for_money,
      :overall_score,
      :comment,
      images: []
    )
  end
end
