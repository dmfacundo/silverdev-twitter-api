require "test_helper"

class AccountTest < ActiveSupport::TestCase
  def main_account = @main ||= accounts(:one)
  def friend = @friend ||= accounts(:two)

  test "name is not empty" do
    account = Account.new(name: "")
    assert_not account.save
    assert account.errors[:name].include?("can't be blank")
  end

  test "name is unique" do
    first_account = accounts(:one)
    account = Account.new(name: first_account.name)
    assert_not account.save
    assert account.errors[:name].include?("has already been taken")
  end

  test "name is not too long" do
    account = Account.new(name: "a" * 51)
    assert_not account.save
    assert account.errors[:name].include?("is too long (maximum is 50 characters)")
  end

  test "name is not too short" do
    account = Account.new(name: "a" * 4)
    assert_not account.save
    assert account.errors[:name].include?("is too short (minimum is 5 characters)")
  end

  test "not cointains special characters" do
    account = Account.new(name: "a" * 5 + "@")
    assert_not account.save
    assert account.errors[:name].include?("only allows letters and numbers")
  end

  test "not cointains spaces" do
    account = Account.new(name: "a" * 5 + " ")
    assert_not account.save
    assert account.errors[:name].include?("only allows letters and numbers")
  end

  test "could follow other accounts" do
    main_account.follow(friend)
    assert main_account.friends.include?(friend)
  end

  test "shouldn't follow the same account twice" do
    main_account.follow(friend)
    assert_not main_account.follow(friend)
  end

  test "shouldn't follow itself" do
    assert_not main_account.follow(main_account)
    assert_not main_account.friends.include?(main_account)
  end
end
