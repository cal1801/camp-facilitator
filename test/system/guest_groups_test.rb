require "application_system_test_case"

class GuestGroupsTest < ApplicationSystemTestCase
  setup do
    @guest_group = guest_groups(:one)
  end

  test "visiting the index" do
    visit guest_groups_url
    assert_selector "h1", text: "Guest Groups"
  end

  test "creating a Guest group" do
    visit guest_groups_url
    click_on "New Guest Group"

    fill_in "Arrives", with: @guest_group.arrives
    fill_in "Description", with: @guest_group.description
    fill_in "Leaves", with: @guest_group.leaves
    fill_in "Name", with: @guest_group.name
    click_on "Create Guest group"

    assert_text "Guest group was successfully created"
    click_on "Back"
  end

  test "updating a Guest group" do
    visit guest_groups_url
    click_on "Edit", match: :first

    fill_in "Arrives", with: @guest_group.arrives
    fill_in "Description", with: @guest_group.description
    fill_in "Leaves", with: @guest_group.leaves
    fill_in "Name", with: @guest_group.name
    click_on "Update Guest group"

    assert_text "Guest group was successfully updated"
    click_on "Back"
  end

  test "destroying a Guest group" do
    visit guest_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Guest group was successfully destroyed"
  end
end
