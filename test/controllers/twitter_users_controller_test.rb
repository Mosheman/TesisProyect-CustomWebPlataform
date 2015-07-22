require 'test_helper'

class TwitterUsersControllerTest < ActionController::TestCase
  setup do
    @twitter_user = twitter_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitter_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitter_user" do
    assert_difference('TwitterUser.count') do
      post :create, twitter_user: { connections: @twitter_user.connections, description: @twitter_user.description, favourites_count: @twitter_user.favourites_count, followers_count: @twitter_user.followers_count, friends_count: @twitter_user.friends_count, lang: @twitter_user.lang, listed_count: @twitter_user.listed_count, location: @twitter_user.location, name: @twitter_user.name, profile_background_color: @twitter_user.profile_background_color, profile_link_color: @twitter_user.profile_link_color, profile_sidebar_border_color: @twitter_user.profile_sidebar_border_color, profile_sidebar_fill_color: @twitter_user.profile_sidebar_fill_color, profile_text_color: @twitter_user.profile_text_color, statuses_count: @twitter_user.statuses_count, time_zone: @twitter_user.time_zone, utc_offset: @twitter_user.utc_offset }
    end

    assert_redirected_to twitter_user_path(assigns(:twitter_user))
  end

  test "should show twitter_user" do
    get :show, id: @twitter_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twitter_user
    assert_response :success
  end

  test "should update twitter_user" do
    patch :update, id: @twitter_user, twitter_user: { connections: @twitter_user.connections, description: @twitter_user.description, favourites_count: @twitter_user.favourites_count, followers_count: @twitter_user.followers_count, friends_count: @twitter_user.friends_count, lang: @twitter_user.lang, listed_count: @twitter_user.listed_count, location: @twitter_user.location, name: @twitter_user.name, profile_background_color: @twitter_user.profile_background_color, profile_link_color: @twitter_user.profile_link_color, profile_sidebar_border_color: @twitter_user.profile_sidebar_border_color, profile_sidebar_fill_color: @twitter_user.profile_sidebar_fill_color, profile_text_color: @twitter_user.profile_text_color, statuses_count: @twitter_user.statuses_count, time_zone: @twitter_user.time_zone, utc_offset: @twitter_user.utc_offset }
    assert_redirected_to twitter_user_path(assigns(:twitter_user))
  end

  test "should destroy twitter_user" do
    assert_difference('TwitterUser.count', -1) do
      delete :destroy, id: @twitter_user
    end

    assert_redirected_to twitter_users_path
  end
end
