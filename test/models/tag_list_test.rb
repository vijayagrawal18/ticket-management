require 'test_helper'

class TagListTest < ActiveSupport::TestCase

  test "having_all scope with one tag" do
    tag_ids = [tags(:two).id]
    assert_equal 2, TagList.having_all(tag_ids, "Organization").pluck(:taggable_id).count
  end

  test "having_all scope with multiple tags" do
    taggable_ids = TagList.having_all(tag_ids, "Organization").pluck :taggable_id
    assert_equal 1, taggable_ids.count
    assert_equal organizations(:one).id, taggable_ids.first
  end

  test "having_all scope with multiple tags is order agnostic" do
    taggable_ids = TagList.having_all(tag_ids.reverse, "Organization").pluck :taggable_id
    assert_equal 1, taggable_ids.count
    assert_equal organizations(:one).id, taggable_ids.first
  end

  private

  def tag_ids
    [tags(:one).id, tags(:two).id]
  end
end
