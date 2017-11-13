require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "search by datetime" do
    @user.update(created_at: "2013-08-04 11:03:27")
    filtered = User.search_by("created_at", "2013-08-04 11:03:27")
    assert_equal @user, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by datetime invalid" do
    @user.update(created_at: "2013-08-04 11:03:27")
    filtered = User.search_by("created_at", "random")
    assert_equal 0, filtered.count
  end

  test "search by boolean true" do
    filtered = User.search_by("active", "true")
    assert_equal 2, filtered.count
  end

  test "search by boolean false" do
    filtered = User.search_by("active", "false")
    assert_equal 1, filtered.count
  end

  test "search by boolean invalid" do
    filtered = User.search_by("active", "random")
    assert_equal 0, filtered.count
  end

  test "search by tags" do
    filtered = User.search_by("tags", tags(:two).name)
    assert_equal @user, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by tags insensitive" do
    filtered = User.search_by("tags", "TaG2")
    assert_equal @user, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by empty tag" do
    filtered = User.search_by("tags", "")
    assert_equal 2, filtered.count
  end

  test "search by organization" do
    filtered = User.search_by("organization_id", organizations(:one)._id)
    assert_equal @user, filtered.first
    assert_equal 2, filtered.count
  end

  test "search by organization unassigned" do
    filtered = User.search_by("organization_id", "")
    assert_nil filtered.first.organization
    assert_equal 1, filtered.count
  end

  test "search by name column" do
    filtered = User.search_by("name", @user.name)
    assert_equal @user, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by name case insensitive" do
    filtered = User.search_by("name", @user.name.upcase)
    assert_equal @user, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by _id column" do
    filtered = User.search_by("_id", "#{@user._id}")
    assert_equal @user, filtered.first
    assert_equal 1, filtered.count
  end
end
