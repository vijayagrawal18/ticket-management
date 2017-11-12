require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_url
    assert_response :success
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post tickets_url, params: { ticket: { _id: "1234", assignee_id: @ticket.assignee_id, description: @ticket.description, due_at: @ticket.due_at, external_id: @ticket.external_id, has_incidents: @ticket.has_incidents, organization_id: @ticket.organization_id, priority: @ticket.priority, status: @ticket.status, subject: @ticket.subject, submitter_id: users(:one).id, ticket_type: @ticket.ticket_type, url: @ticket.url, via: @ticket.via } }
    end

    assert_redirected_to ticket_url(Ticket.last)
  end

  test "should show ticket" do
    get ticket_url(@ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_url(@ticket)
    assert_response :success
  end

  test "should update ticket" do
    patch ticket_url(@ticket), params: { ticket: { _id: @ticket._id, assignee_id: @ticket.assignee_id, description: @ticket.description, due_at: @ticket.due_at, external_id: @ticket.external_id, has_incidents: @ticket.has_incidents, organization_id: @ticket.organization_id, priority: @ticket.priority, status: @ticket.status, subject: @ticket.subject, submitter_id: users(:one).id, ticket_type: @ticket.ticket_type, url: @ticket.url, via: @ticket.via } }
    assert_redirected_to ticket_url(@ticket)
  end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete ticket_url(@ticket)
    end

    assert_redirected_to tickets_url
  end
end
