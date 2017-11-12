require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:one)
  end

  test "should get index" do
    get organizations_url
    assert_equal 3, assigns(:organizations).count
    assert_response :success
  end

  test "should successfully search" do
    get organizations_url, params: {"field" => "_id", "value" => @organization._id}
    assert_equal 1, assigns(:organizations).count
    assert_response :success
  end

  test "should detect invalid field" do
    get organizations_url, params: {"field" => "asd_id", "value" => @organization._id}
    assert_equal 3, assigns(:organizations).count
    assert_equal "asd_id not available for search", flash[:alert]
    assert_response :success
  end

  test "should show warning when value given but field not" do
    get organizations_url, params: {"value" => @organization._id}
    assert_equal 3, assigns(:organizations).count
    assert_equal "Please select a field", flash[:alert]
    assert_response :success
  end

  test "should get new" do
    get new_organization_url
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      post organizations_url, params: { organization: { _id: 123, details: @organization.details, external_id: @organization.external_id, name: @organization.name, shared_tickets: @organization.shared_tickets, url: @organization.url } }
    end

    assert_redirected_to organization_url(Organization.last)
  end

  test "should show organization" do
    get organization_url(@organization)
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_url(@organization)
    assert_response :success
  end

  test "should update organization" do
    patch organization_url(@organization), params: { organization: { _id: @organization._id, details: @organization.details, external_id: @organization.external_id, name: @organization.name, shared_tickets: @organization.shared_tickets, url: @organization.url } }
    assert_redirected_to organization_url(@organization)
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete organization_url(@organization)
    end

    assert_redirected_to organizations_url
  end
end
