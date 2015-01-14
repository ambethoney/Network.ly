module ProjectDashboard
  module DatabaseHelper

      def authorize!
        if session[:name] != params[:username]
          redirect to('/')
        end
      end

      def get_user_info
         response = HTTParty.get("https://api.linkedin.com/v1/people/~:(first-name,last-name,email-address,picture-url,headline)?format=json",
        :headers => {
          "Authorization" => "Bearer #{session[:access_token]}",
          "User-Agent"    => "Progress notes"
          }
          )
      session[:email]       = response["emailAddress"]
      session[:f_name]      = response["firstName"]
      session[:l_name]      = response["lastName"]
      session[:user_image]  = response["pictureUrl"]
      session[:job_title]   = response["headline"]
      session[:provider]    = "LinkedIn"
    end

  end #ends DatabaseHelper
end #ends User_Info
