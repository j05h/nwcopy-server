class User < ActiveRecord::Base
  validates_presence_of :github_account
  validates_uniqueness_of :github_account
  before_create :make_access_token
  has_many :pastes, :order => 'updated_at DESC'

  def make_access_token
    self.access_token = UUID.generate
  end

  def credentials
    "#{github_account}:#{access_token}"
  end

  class << self
    def find_user id
      find :first, :conditions => ['id = ? or github_account = ?', id, id]
    end
  end
end

