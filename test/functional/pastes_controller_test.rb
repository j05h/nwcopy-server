require 'test_helper'

class PastesControllerTest < ActionController::TestCase
  test 'takes a copy' do
    assert_difference 'Paste.count' do
      post :create, {"data" => "this is the body i'm sending"}
    end
    assert_match /http:\/\/test.host\/pastes\/\w*/, response.body
  end

  test 'takes a binary file' do
    assert_difference 'Paste.count' do
      post :create, :data => fixture_file('/rails.png', 'image/png')
    end
    assert_equal 'rails.png', Paste.all.first.filename
  end

  test 'pastes the data' do
    paste = binary_paste
    get :show, :id => paste.guid
    assert_equal paste.content, response.body
    assert_equal paste.filename, response.headers['Location']
  end
end
