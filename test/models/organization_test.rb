require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "search by tags" do
    filtered = Organization.search_by("tag", tags(:two).name)
    assert_equal organizations(:one), filtered.first
    assert_equal 1, filtered.count
  end

  test "search by tags negative" do
    filtered = Organization.search_by("tag", "random")
    assert_equal 0, filtered.count
  end

  test "search by domains" do
    filtered = Organization.search_by("domain", domains(:d1).name)
    assert_equal organizations(:one), filtered.first
    assert_equal 1, filtered.count
  end

  test "search by domains case insensitive" do
    filtered = Organization.search_by("domain", domains(:d1).name.upcase)
    assert_equal organizations(:one), filtered.first
    assert_equal 1, filtered.count
  end

  test "search by domains negative" do
    filtered = Organization.search_by("domain", "random")
    assert_equal 0, filtered.count
  end

  test "search by empty domains" do
    filtered = Organization.search_by("domain", "")
    assert_equal 2, filtered.count
    assert_equal [], filtered.map(&:domains).flatten
  end
end
