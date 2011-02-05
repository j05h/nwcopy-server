require 'test_helper'

class PasteTest < ActiveRecord::TestCase
  test 'initialize' do
    paste = Paste.new :content => 'this is some data', :user => current_user
    paste.save
    assert paste.guid
    assert paste.content
    assert_equal current_user, paste.user
  end

  test 'uniqueness' do
    assert_difference 'Paste.count' do
      binary_paste
    end
    assert_no_difference 'Paste.count' do
      binary_paste true
    end
  end

  test 'read' do
    paste = binary_paste
    read = Paste.find paste.id
    assert_equal paste.content, read.content
  end

  test 'filename' do
    paste = Paste.new :content => 'foo', :user => current_user, :filename => '-'
    assert_nil paste.filename
  end

  test 'updates timestamp when pasting the same thing again' do
    paste = nil
    assert_difference 'Paste.count' do
      paste = text_paste
    end

    assert_no_difference 'Paste.count' do
      other = text_paste true
      assert !other.save
    end


    dbpaste = Paste.find_by_guid paste.guid
    assert dbpaste.updated_at > paste.updated_at, "Repastes should update the timestamp"
  end
end
