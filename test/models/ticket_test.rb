require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  setup do
    @ticket = tickets :three
  end

  test "search by tags" do
    filtered = Ticket.search_by("tags", tags(:two).name)
    assert_equal @ticket, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by tags negative" do
    filtered = Ticket.search_by("tags", "random")
    assert_equal 0, filtered.count
  end

  test "search by submitter" do
    filtered = Ticket.search_by("submitter_id", "#{@ticket.submitter._id}")
    assert_equal @ticket, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by assignee" do
    filtered = Ticket.search_by("assignee_id", "#{@ticket.assignee._id}")
    assert_equal @ticket, filtered.first
    assert_equal 1, filtered.count
  end

  test "search by unassigned" do
    filtered = Ticket.search_by("assignee_id", "")
    assert_equal tickets(:two), filtered.first
    assert_nil filtered.first.assignee
    assert_equal 1, filtered.count
  end
end
