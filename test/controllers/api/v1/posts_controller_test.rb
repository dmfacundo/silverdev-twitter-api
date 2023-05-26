class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:one)
    @post = posts(:one)
  end

  test "should create a post" do
    post "/api/v1/posts", params: { post: { body: "a" * 5 } }, as: :json
    assert_response :success
  end

  test "should return unprocessable_entity on create error" do
    post "/api/v1/posts", params: { post: { body: "a" * 2 } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should not take unpermitted params on create" do
    post "/api/v1/posts", params: { post: { id: 500, body: "a" * 5 } }, as: :json
    assert_response :success
    assert_not Post.last.id == 500
  end

  test "should return feed" do
    get "/api/v1/feed", as: :json
    assert_response :success
  end

  test "should return feed with pagination" do
    get "/api/v1/feed?page=2", as: :json
    assert_response :success
  end

  test "should return bad_request if page is less than 0" do
    get "/api/v1/feed?page=-1", as: :json
    assert_response :bad_request
  end
end
