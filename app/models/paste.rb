require 'digest/sha1'

class Paste < ActiveRecord::Base
  validates_presence_of :user_id
  validates_uniqueness_of :guid, :scope => :user_id

  belongs_to :user

  def initialize params
    data     = params[:content]
    digest   = Digest::SHA1.hexdigest data
    filename = params[:filename].match(/-/) ? nil : params[:filename] if params[:filename]

    super :guid => digest, :content => data, :user_id => params[:user].id, :filename => filename
  end
end
