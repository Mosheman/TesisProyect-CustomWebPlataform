require 'test_helper'

class TwitterCredentialsControllerTest < ActionController::TestCase
  setup do
    @twitter_credential = twitter_credentials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitter_credentials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitter_credential" do
    assert_difference('TwitterCredential.count') do
      post :create, twitter_credential: { access_token: @twitter_credential.access_token, access_token_secret: @twitter_credential.access_token_secret, consumer_key: @twitter_credential.consumer_key, consumer_secret: @twitter_credential.consumer_secret, user_id: @twitter_credential.user_id }
    end

    assert_redirected_to twitter_credential_path(assigns(:twitter_credential))
  end

  test "should show twitter_credential" do
    get :show, id: @twitter_credential
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twitter_credential
    assert_response :success
  end

  test "should update twitter_credential" do
    patch :update, id: @twitter_credential, twitter_credential: { access_token: @twitter_credential.access_token, access_token_secret: @twitter_credential.access_token_secret, consumer_key: @twitter_credential.consumer_key, consumer_secret: @twitter_credential.consumer_secret, user_id: @twitter_credential.user_id }
    assert_redirected_to twitter_credential_path(assigns(:twitter_credential))
  end

  test "should destroy twitter_credential" do
    assert_difference('TwitterCredential.count', -1) do
      delete :destroy, id: @twitter_credential
    end

    assert_redirected_to twitter_credentials_path
  end
end
