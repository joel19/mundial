require "test_helper"

class PredictionsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @t1 = NationalTeam.create!(name: "Smoke A")
    @t2 = NationalTeam.create!(name: "Smoke B")
    @match = Match.create!(home_team: @t1, away_team: @t2)
    @user = User.create!(email: "smoke@example.com", password: "password123")
  end

  test "unauthenticated user is redirected to sign in" do
    get predictions_path
    assert_redirected_to new_user_session_path
  end

  test "authenticated user can create, edit and delete a prediction" do
    sign_in @user

    get predictions_path
    assert_response :success
    assert_select "a", text: "Pronosticar"

    get new_prediction_path(match_id: @match.id)
    assert_response :success

    assert_difference "Prediction.count", 1 do
      post predictions_path(match_id: @match.id), params: { prediction: { predicted_home_score: 2, predicted_away_score: 1 } }
    end
    prediction = Prediction.last
    assert_redirected_to predictions_path

    get predictions_path
    assert_select ".badge--prediction-incorrect", text: /2 - 1/

    patch prediction_path(prediction), params: { prediction: { predicted_home_score: 3, predicted_away_score: 0 } }
    assert_redirected_to predictions_path
    assert_equal 3, prediction.reload.predicted_home_score

    assert_difference "Prediction.count", -1 do
      delete prediction_path(prediction)
    end
  end

  test "a second user cannot edit another user's prediction" do
    prediction = @user.predict(@match, home_score: 1, away_score: 1)
    other_user = User.create!(email: "other@example.com", password: "password123")
    sign_in other_user

    get edit_prediction_path(prediction)
    assert_response :not_found
  end
end
