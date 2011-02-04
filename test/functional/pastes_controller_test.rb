require 'test_helper'

class PastesControllerTest < ActionController::TestCase
  test 'takes a copy' do
    assert_difference 'Paste.count' do
      raw_post :create, {}, "this is the body i'm sending"
    end
    assert_match /http:\/\/test.host\/pastes\/\w*/, response.body
  end

  test 'pastes the data' do
    paste = binary_paste
    get :show, :id => paste.guid
    assert_equal paste.content, response.body
  end
end
