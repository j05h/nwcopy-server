class PastesController < ApplicationController
  protect_from_forgery :except => [:create]

  before_filter :authenticate, :only => [:create]

  def create
    content, filename = read_data
    paste = Paste.new :content => content, :filename => filename, :user => @user
    paste.save
    render :text => "http://#{request.host_with_port}/pastes/#{paste.guid}", :status => 201
  end

  def show
    paste = if params[:id]
              Paste.find_by_guid params[:id]
            elsif authenticate
              @user.pastes.first
            end

    headers['Location'] = paste.filename || paste.guid
    send_data paste.content
  end

  private
  def read_data
    data = params[:data]
    if data.respond_to? :read
      [data.read, data.original_filename]
    else
      [data, nil]
    end
  end

  def authenticate
    authenticate_or_request_with_http_basic do |github_account, access_token|
      @user = User.find_by_github_account_and_access_token github_account, access_token
    end
  end
end
