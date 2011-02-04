class UsersController < ApplicationController
  respond_to :html
  respond_to :xml, :json, :only => [:create, :show]
  before_filter :me, :only => [:show]

  def show
    respond_with @me
  end

  # {"user" => {"company"=>nil, "name"=>"Josh K", "gravatar_id"=>"ab09602ee984ee921137df751c9e4b00",
  # "plan"=>{"name"=>"small", "collaborators"=>5, "space"=>1228800, "private_repos"=>10},
  # "created_at"=>"2009/10/05 16:37:06 -0700", "location"=>"Austin, TX", "blog"=>nil, "public_gist_count"=>3,
  # "public_repo_count"=>2, "collaborators"=>1, "disk_usage"=>4108, "following_count"=>0, "id"=>135544,
  # "type"=>"User", "private_gist_count"=>17, "owned_private_repo_count"=>2, "followers_count"=>1,
  # "total_private_repo_count"=>2, "login"=>"j05h", "email"=>nil}
  def callback
    access_token = client.web_server.get_access_token(params[:code], :redirect_uri => oauth_redirect_uri)
    data = access_token.get('/api/v2/json/user/show')["user"]

    # here's where we create a user
    attributes = {:github_account       => data["login"],
                   :github_access_token => access_token.token}
    %w(email name gravatar_id company location).each {|k| attributes[k] = data[k]}

    if(user = User.find_by_github_account attributes[:github_account])
      user.update_attributes(attributes)
    else
      user = User.new(attributes)
      user.save
    end
    session[:username] = user.github_account
    redirect_to '/me'
  end


end

