require 'test_helper'

class PasteTest < ActiveRecord::TestCase
  test 'initialize' do
    paste = Paste.new :content => 'this is some data'
    paste.save
    assert paste.guid
    assert paste.content
  end

  test 'read' do
    paste = binary_paste
    read = Paste.find paste.id
    assert_equal paste.content, read.content
  end
end
