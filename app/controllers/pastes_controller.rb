class PastesController < ApplicationController
  protect_from_forgery :except => [:create]
  def create
    paste = Paste.new request.raw_post
    paste.save
    File.open("create.png", "wb") do |f|
      f << paste.content
    end
    render :text => "http://#{request.host_with_port}/pastes/#{paste.guid}"
  end

  def show
    paste = Paste.find_by_guid params[:id]
    File.open("show.png", "wb") do |f|
      f << paste.content
    end
    send_data paste.content
  end
end
