require 'digest/sha1'

class Paste < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :guid

  before_create :check_guid

  belongs_to :user

  def initialize params
    data     = params[:content]
    digest   = Digest::SHA1.hexdigest data
    filename = params[:filename].match(/-/) ? nil : params[:filename] if params[:filename]

    super :guid => digest, :content => data, :user_id => params[:user].id, :filename => filename
  end

  def check_guid
    if model = self.class.find_by_guid(guid)
      model.touch
      false
    else
      true
    end
  end
end
