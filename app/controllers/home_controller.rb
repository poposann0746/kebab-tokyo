class HomeController < ApplicationController
  def index
    eager_load = { shop: [], images_attachments: :blob }

    if user_signed_in?
      @my_reviews = current_user.reviews.includes(eager_load).order(created_at: :desc).limit(10)
    end

    @recommended_reviews = Review.includes(eager_load).order(overall_score: :desc).limit(10)
    @shinjuku_reviews = Review.includes(eager_load).joins(:shop).where(shops: { area: "新宿" }).order(created_at: :desc).limit(10)
    @shibuya_reviews = Review.includes(eager_load).joins(:shop).where(shops: { area: "渋谷" }).order(created_at: :desc).limit(10)
  end
end
