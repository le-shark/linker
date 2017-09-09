require 'test_helper'

class SavingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get savings_create_url
    assert_response :success
  end

end
