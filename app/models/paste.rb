require 'digest/sha1'

class Paste < ActiveRecord::Base
  def initialize params
    data = params[:content]
    digest = Digest::SHA1.hexdigest data
    super :guid => digest, :content => data, :user_id => 1, :filename => params[:filename]
  end
end
