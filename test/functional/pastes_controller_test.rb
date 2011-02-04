require 'test_helper'

class PastesControllerTest < ActionController::TestCase
  setup do
    @user = current_user
    @credentials = ActionController::HttpAuthentication::Basic.encode_credentials(@user.github_account, @user.access_token)
  end

  test 'copies text' do
    assert_difference 'Paste.count' do
      request.env["HTTP_AUTHORIZATION"] = @credentials
      post :create, {"data" => "this is the body i'm sending"}
    end
    assert_match /http:\/\/test.host\/pastes\/\w*/, response.body
  end

  test 'copies a binary file' do
    assert_difference 'Paste.count' do
      request.env["HTTP_AUTHORIZATION"] = @credentials
      post :create, {:data => fixture_file('/rails.png', 'image/png')}
    end
    assert_equal 'rails.png', Paste.all.first.filename
    assert_equal @user, Paste.all.first.user
  end

  test 'pastes text data' do
    paste = text_paste

    get :show, {:id => paste.guid}

    assert_equal paste.content, response.body
    assert_equal paste.guid, response.headers['Location']
  end

  test 'pastes binary data' do
    paste = binary_paste
    get :show, {:id => paste.guid}
    assert_equal paste.content, response.body
    assert_equal paste.filename, response.headers['Location']
  end

  test 'pastes the most recent data' do
    binary_paste
    paste = text_paste

    request.env["HTTP_AUTHORIZATION"] = @credentials
    get :show

    assert_equal paste.content, response.body
  end

  test 'rejects copy if no basic_auth' do
    post :create, {"data" => "awesome data i'm putting in the system."}
    assert_response 401
  end
end
