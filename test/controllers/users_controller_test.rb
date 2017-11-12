require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
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
