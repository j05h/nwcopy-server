require 'test_helper'

class PastesControllerTest < ActionController::TestCase
  test 'copies text' do
    assert_difference 'Paste.count' do
      post :create, {"data" => "this is the body i'm sending"}
    end
    assert_match /http:\/\/test.host\/pastes\/\w*/, response.body
  end

  test 'copies a binary file' do
    assert_difference 'Paste.count' do
      post :create, :data => fixture_file('/rails.png', 'image/png')
    end
    assert_equal 'rails.png', Paste.all.first.filename
  end

  test 'pastes text data' do
    paste = Paste.new :content => "this is some text"
    paste.save

    get :show, :id => paste.guid

    assert_equal paste.content, response.body
    assert_equal paste.guid, response.headers['Location']
  end

  test 'pastes binary data' do
    paste = binary_paste
    get :show, :id => paste.guid
    assert_equal paste.content, response.body
    assert_equal paste.filename, response.headers['Location']
  end
end
