require "test_helper"

class PostTest < ActiveSupport::TestCase
  def account = accounts(:one)
  def friend = @friend ||= accounts(:two)
  def another_friend = @another_friend ||= accounts(:three)
  def feed = @feed ||= Post.feed(account, 1)

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

  test "feed should return posts from friends" do
    account.follow(friend)
    account.follow(another_friend)
    posts = Post.where(account_id: [friend.id, another_friend.id])
    assert posts.all? { |post| feed.find_by(id: post.id).present? }
  end

  test "feed shouldn't return posts from not friends" do
    not_friend = Account.create(name: "NotFriend")
    post = not_friend.posts.create(body: "Lorem ipsum")
    assert_not feed.find_by(id: post.id).present?
  end

  test "feed shouldn't return post from itself" do
    post = account.posts.create(body: "Lorem ipsum")
    assert_not feed.find_by(id: post.id).present?
  end

  test "feed should return posts in descending order" do
    account.follow(friend)
    account.follow(another_friend)
    posts = Post.where(account_id: [friend.id, another_friend.id])
    assert_equal posts.order(created_at: :desc).map(&:id), feed.map(&:id)
  end

  test "feed should take a valid page number" do
    assert_raises { Post.feed(account, -1) }
  end
end
