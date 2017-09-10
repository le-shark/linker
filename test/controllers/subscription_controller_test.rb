require 'test_helper'

class SubscriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get subscription_create_url
    assert_response :success
  end

end
