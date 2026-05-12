class Admin::UsersController < Admin::BaseController
  PER_PAGE = 30

  def index
    page = [ params[:page].to_i, 1 ].max
    offset = (page - 1) * PER_PAGE

    @users = User
      .left_joins(:reviews)
      .group("users.id")
      .select("users.*, COUNT(reviews.id) AS reviews_count")
      .order("users.created_at DESC")
      .limit(PER_PAGE)
      .offset(offset)

    @current_page = page
    @total_count = User.count
    @total_pages = (@total_count.to_f / PER_PAGE).ceil
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.includes(:shop).order(created_at: :desc)
  end
end
