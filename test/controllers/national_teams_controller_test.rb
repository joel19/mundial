require "test_helper"

class NationalTeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @national_team = national_teams(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get national_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_national_team_url
    assert_response :success
  end

  test "should create national_team" do
    assert_difference("NationalTeam.count") do
      post national_teams_url, params: { national_team: { name: @national_team.name } }
    end

    assert_redirected_to national_team_url(NationalTeam.last)
  end

  test "should show national_team" do
    get national_team_url(@national_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_national_team_url(@national_team)
    assert_response :success
  end

  test "should update national_team" do
    patch national_team_url(@national_team), params: { national_team: { name: @national_team.name } }
    assert_redirected_to national_team_url(@national_team)
  end

  test "should destroy national_team" do
    assert_difference("NationalTeam.count", -1) do
      delete national_team_url(@national_team)
    end

    assert_redirected_to national_teams_url
  end
end
