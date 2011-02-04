class ApplicationController < ActionController::Base
  protect_from_forgery

  def client
    OAuth2::Client.new('921a9ebc5e668687cb47', 'd91661dc7e368d16cca5f77366bf8d4c9130795d',
                      :site             => 'https://github.com',
                      :authorize_url    => 'https://github.com/login/oauth/authorize',
                      :access_token_url => 'https://github.com/login/oauth/access_token',
                      :parse_json       => true)
  end

  def me
    @me ||= User.find_by_github_account session[:username]

    if @me
      session[:username] = @me.github_account
    else
      redirect_to client.web_server.authorize_url :redirect_uri => oauth_redirect_uri, :scope => 'user,gist'
      return false
    end
    @me
  end
  helper_method :me

  def oauth_redirect_uri
    uri = URI.parse request.url
    uri.path = '/oauth/callback'
    uri.query = nil
    uri.to_s
  end
end
