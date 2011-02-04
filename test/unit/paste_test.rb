require 'test_helper'

class PasteTest < ActiveRecord::TestCase
  test 'initialize' do
    paste = Paste.new :content => 'this is some data', :user => current_user
    paste.save
    assert paste.guid
    assert paste.content
    assert_equal current_user, paste.user
  end

  test 'read' do
    paste = binary_paste
    read = Paste.find paste.id
    assert_equal paste.content, read.content
  end
end
