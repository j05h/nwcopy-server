class PastesController < ApplicationController
  protect_from_forgery :except => [:create]
  def create
    content, filename = read_data
    paste = Paste.new :content => content, :filename => filename
    paste.save
    render :text => "http://#{request.host_with_port}/pastes/#{paste.guid}", :status => 201
  end

  def show
    paste = Paste.find_by_guid params[:id]
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
end
