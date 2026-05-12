class Admin::DashboardController < Admin::BaseController
  def index
    @users_count = User.count
    @shops_count = Shop.count
    @reviews_count = Review.count
  end
end
