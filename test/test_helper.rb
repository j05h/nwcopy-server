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

  def binary_paste
    data = File.new(File.join(Rails.root, 'test/fixtures/rails.png')).read
    paste = Paste.new :content => data, :filename => 'rails.png'
    paste.save
    paste
  end

  def fixture_file filename, content_type
    file = fixture_file_upload(filename, content_type)

    def file.read
      File.open(self.local_path).read
    end

    file
  end

end
