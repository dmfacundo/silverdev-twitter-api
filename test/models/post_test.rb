require "test_helper"

class PostTest < ActiveSupport::TestCase
  def account = accounts(:one)

  test "body is at least 3 charachters long" do
    post = account.posts.new(body: "a" * 2)
    assert_not post.save
    assert post.errors[:body].include?("is too short (minimum is 3 characters)")
  end

  test "body is at most 100 charachters long" do
    post = account.posts.new(body: "a" * 101)
    assert_not post.save
    assert post.errors[:body].include?("is too long (maximum is 100 characters)")
  end

  test "post should belongs to an account" do
    post = Post.new(body: "a" * 3)
    assert_not post.save
    assert post.errors[:account].include?("must exist")
  end

  test "should be able to create a post" do
    post = account.posts.new(body: "a" * 3)
    assert post.save
  end
end
