module ProjectDashboard
  class Server < Sinatra::Base

    enable :logging, :sessions

    include LinkedinHelper
    include DribbbleHelper

    configure :development do
      register Sinatra::Reloader
      require 'pry'
      require 'redis'
      $redis = Redis.new
    end

    get('/') do
      # LINKEDIN PARAMS
      linkedin_query_params = URI.encode_www_form({
        :response_type => "code",
        :client_id     =>  ENV["LINKEDIN_OAUTH_ID"],
        :state         => "DK8H7MSITBATCMT65839",
        :redirect_uri  => "http://localhost:9292/linkedin/oauth_callback"
        })
      @linkedin_auth_url = "https://www.linkedin.com/uas/oauth2/authorization?" + linkedin_query_params


      render :erb, :index, layout: :index_layout
    end

    get '/home' do
      # get user's contacts from LinkedIn API
      @contacts = get_contacts(session[:access_token])
      @info = get_contact_info(session[:access_token],params[:name])


      # DRIBBBLE PARAMS
      query_params = URI.encode_www_form({
        :client_id     => ENV["DRIBBBLE_OAUTH_ID"],
      })
      @dribbble_auth_url = "https://dribbble.com/oauth/authorize?" + query_params
      @dribbble_user_info = dribbble_user_info
      render :erb, :home, layout: :default
    end

    get('/linkedin/oauth_callback') do
      response = HTTParty.post("https://www.linkedin.com/uas/oauth2/accessToken",
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
      session.merge! user_info(session[:access_token]) # put user info in session

      redirect('/home')
    end


    get("/dribbble/oauth_callback") do
      response = HTTParty.post(
        "https://dribbble.com/oauth/token",
        :body => {
          :code          => params[:code],
          :client_id         => ENV["DRIBBBLE_OAUTH_ID"],
          :client_secret     => ENV["DRIBBBLE_OAUTH_SECRET"],
        },
        :headers => {
          "Accept" => "application/json"
        }
      )

      session[:access_token] = response["access_token"]
      session.merge! user_info(session[:access_token])
      redirect to('/home')
    end

    get('/logout') do
      session[:name] = session[:access_token] = nil # dual assignment!
      redirect to("/")
    end


    post('/home') do
      id = $redis.incr("every_contact")
      $redis.hmset("contact:#{id}",
        "f_name", params["f_name"],
        "l_name", params["l_name"],
        )
      $redis.lpush("contacts_list", id)
      redirect to '/home'
    end

    # TODO: change to query params to handle request_rul
    get('/contact_info/:name') do
      @info = get_contact_info(session[:access_token],params[:name])
      render :erb, :contact, layout: :contact_layout
    end

    def authorize!
      if session[:name] != params[:username]
        redirect to('/')
      end
    end
  end #ends Server
end #ends ProjectDashboard

