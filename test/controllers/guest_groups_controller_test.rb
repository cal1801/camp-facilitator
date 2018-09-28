require 'test_helper'

class GuestGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guest_group = guest_groups(:one)
  end

  test "should get index" do
    get guest_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_guest_group_url
    assert_response :success
  end

  test "should create guest_group" do
    assert_difference('GuestGroup.count') do
      post guest_groups_url, params: { guest_group: { arrives: @guest_group.arrives, description: @guest_group.description, leaves: @guest_group.leaves, name: @guest_group.name } }
    end

    assert_redirected_to guest_group_url(GuestGroup.last)
  end

  test "should show guest_group" do
    get guest_group_url(@guest_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_guest_group_url(@guest_group)
    assert_response :success
  end

  test "should update guest_group" do
    patch guest_group_url(@guest_group), params: { guest_group: { arrives: @guest_group.arrives, description: @guest_group.description, leaves: @guest_group.leaves, name: @guest_group.name } }
    assert_redirected_to guest_group_url(@guest_group)
  end

  test "should destroy guest_group" do
    assert_difference('GuestGroup.count', -1) do
      delete guest_group_url(@guest_group)
    end

    assert_redirected_to guest_groups_url
  end
end
