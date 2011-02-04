class PastesController < ApplicationController
  protect_from_forgery :except => [:create]
  def create
    data = params[:data]
    content, filename = if data.respond_to? :read
      [data.read, data.original_filename]
    else
      [data, nil]
    end
    paste = Paste.new :content => content, :filename => filename
    paste.save
    render :text => "http://#{request.host_with_port}/pastes/#{paste.guid}", :status => 201
  end

  def show
    paste = Paste.find_by_guid params[:id]
    headers['Location'] = paste.filename
    send_data paste.content
  end
end
