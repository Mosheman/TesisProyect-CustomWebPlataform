require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    @tweet = tweets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tweet" do
    assert_difference('Tweet.count') do
      post :create, tweet: { favorite_count: @tweet.favorite_count, filter_level: @tweet.filter_level, in_reply_to_screen_name: @tweet.in_reply_to_screen_name, in_reply_to_status_id: @tweet.in_reply_to_status_id, in_reply_to_user_id: @tweet.in_reply_to_user_id, lang: @tweet.lang, retweet_count: @tweet.retweet_count, source: @tweet.source, text: @tweet.text }
    end

    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should show tweet" do
    get :show, id: @tweet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tweet
    assert_response :success
  end

  test "should update tweet" do
    patch :update, id: @tweet, tweet: { favorite_count: @tweet.favorite_count, filter_level: @tweet.filter_level, in_reply_to_screen_name: @tweet.in_reply_to_screen_name, in_reply_to_status_id: @tweet.in_reply_to_status_id, in_reply_to_user_id: @tweet.in_reply_to_user_id, lang: @tweet.lang, retweet_count: @tweet.retweet_count, source: @tweet.source, text: @tweet.text }
    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should destroy tweet" do
    assert_difference('Tweet.count', -1) do
      delete :destroy, id: @tweet
    end

    assert_redirected_to tweets_path
  end
end
