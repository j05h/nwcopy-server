require 'digest/sha1'

class Paste < ActiveRecord::Base
  validates_uniqueness_of :guid
  validates_presence_of :user_id

  belongs_to :user

  def initialize params
    data = params[:content]
    digest = Digest::SHA1.hexdigest data
    super :guid => digest, :content => data, :user_id => params[:user].id, :filename => params[:filename]
  end
end
