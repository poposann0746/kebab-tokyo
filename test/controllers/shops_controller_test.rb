require "test_helper"

class ShopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = shops(:one)
  end

  test "should get index" do
    get shops_url
    assert_response :success
  end

  test "should get show" do
    get shop_url(@shop)
    assert_response :success
  end
end
