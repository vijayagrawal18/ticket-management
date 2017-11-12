require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should successfully search" do
    @user.update(created_at: "2013-08-04 11:03:27")

    get users_url, params: {"field" => "created_at", "value" => "2013-08-04 11:03:27"}
    assert_equal 1, assigns(:users).count
    assert_response :success
  end

  test "should detect invalid field" do
    get users_url, params: {"field" => "asd_id", "value" => @user._id}
    assert_equal 3, assigns(:users).count
    assert_equal "asd_id not available for search", flash[:alert]
    assert_response :success
  end

  test "should show warning when value given but field not" do
    get users_url, params: {"value" => @user._id}
    assert_equal 3, assigns(:users).count
    assert_equal "Please select a field", flash[:alert]
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { _id: 12314, active: @user.active, alias: @user.alias, email: @user.email, external_id: @user.external_id, last_login_at: @user.last_login_at, locale: @user.locale, name: @user.name, organization_id: @user.organization_id, phone: @user.phone, role: @user.role, shared: @user.shared, signature: @user.signature, suspended: @user.suspended, timezone: @user.timezone, url: @user.url, verified: @user.verified } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { _id: @user._id, active: @user.active, alias: @user.alias, email: @user.email, external_id: @user.external_id, last_login_at: @user.last_login_at, locale: @user.locale, name: @user.name, organization_id: @user.organization_id, phone: @user.phone, role: @user.role, shared: @user.shared, signature: @user.signature, suspended: @user.suspended, timezone: @user.timezone, url: @user.url, verified: @user.verified } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
