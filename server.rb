require_relative 'databasehelper'

module ProjectDashboard
  class Server < Sinatra::Base

    enable :logging, :sessions

    include DatabaseHelper

    configure :development do
      register Sinatra::Reloader
      require 'pry'
      require 'redis'
    end


    get('/') do
      query_params = URI.encode_www_form({
        :response_type => "code",
        :client_id     => ENV["LINKEDIN_OAUTH_ID"],
        :state         => "DK8H7MSITBATCMT65839",
        :redirect_uri  => "http://localhost:9292/linkedin/oauth_callback"
        })
      @linkedin_auth_url = "https://www.linkedin.com/uas/oauth2/authorization?" + query_params
      render :erb, :index, layout: :default
    end

    get '/home' do
      render :erb, :home, layout: :default
    end

    get('/linkedin/oauth_callback') do
      response = HTTParty.post(
        "https://www.linkedin.com/uas/oauth2/accessToken?",
        :body => {
          :grant_type     => "authorization_code",
          :code           => params[:code],
          :redirect_uri   => "http://localhost:9292/linkedin/oauth_callback",
          :client_id      => ENV["LINKEDIN_OAUTH_ID"],
          :client_secret  => ENV["LINKEDIN_OAUTH_SECRET"]
        },
        :headers => {
          "Accept"        => "application/json"
        }
      )

      session[:access_token] = response["access_token"]
binding.pry
      @get_user_info
      redirect('/home')
    end

  end #ends Server
end #ends ProjectDashboard
