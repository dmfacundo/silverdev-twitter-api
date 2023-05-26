class Api::V1::AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should create an account" do
    post "/api/v1/accounts", params: { account: { name: "a" * 5 } }, as: :json
    assert_response :success
  end

  test "should return unprocessable_entity on create error" do
    post "/api/v1/accounts", params: { account: { name: "a" * 4 } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should not take unpermitted params on create" do
    post "/api/v1/accounts", params: { account: { id: 500, name: "a" * 5 } }, as: :json
    assert_response :success
    assert_not Account.last.id == 500
  end
end
