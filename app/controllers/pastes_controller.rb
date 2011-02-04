class PastesController < ApplicationController
  protect_from_forgery :except => [:create]
  def create
    file = params[:data]
    paste = Paste.new :content => file.read, :filename => file.original_filename
    paste.save
    render :text => "http://#{request.host_with_port}/pastes/#{paste.guid}", :status => 201
  end

  def show
    paste = Paste.find_by_guid params[:id]
    send_data paste.content
  end
end
