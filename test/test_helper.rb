ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def raw_post(action, params, body)
    @request.env['RAW_POST_DATA'] = body
    response = post(action, params)
    @request.env.delete('RAW_POST_DATA')
    response
  end

  def binary_paste force = false
    return @binary if @binary && !force
    data = File.new(File.join(Rails.root, 'test/fixtures/rails.png')).read
    @binary = Paste.new :content => data, :filename => 'rails.png', :user => current_user
    @binary.save
    @binary
  end

  def text_paste force = false
    return @text if @text && !force
    @text = Paste.new :content => "this is some text", :user => current_user
    @text.save
    @text
  end

  def current_user
    return @user if @user
    @user = User.new :github_account => 'foo'
    @user.save
    @user
  end

  def fixture_file filename, content_type
    file = fixture_file_upload(filename, content_type)

    def file.read
      File.open(self.local_path).read
    end

    file
  end

end
