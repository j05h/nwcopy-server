class User < ActiveRecord::Base
  validates_presence_of :github_account
  validates_uniqueness_of :github_account
  before_create :make_access_token

  def make_access_token
    self.access_token = UUID.generate
  end

  class << self
    def find_user id
      find :first, :conditions => ['id = ? or github_account = ?', id, id]
    end
  end
end

