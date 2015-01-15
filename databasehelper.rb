module ProjectDashboard
  module DatabaseHelper

      def authorize!
        if session[:name] != params[:username]
          redirect to('/')
        end
      end

      def get_user_info
         response = HTTParty.get("https://api.linkedin.com/v1/people/~:(first-name,last-name,email-address)?format=json",
        :headers => {
          "Authorization" => "Bearer #{session[:access_token]}"
          }
          )
      session[:email]       = response["emailAddress"]
      session[:f_name]      = response["firstName"]
      session[:l_name]      = response["lastName"]
      session[:provider]    = "LinkedIn"

    end

    def get_contact_info
      contact_info = HTTParty.get("https://api.linkedin.com/v1/people/~/connections:(headline,first-name,last-name,email-address)?format=json",
      :headers => {
        "Authorization" => "Bearer #{session[:access_token]}"
      })
      # NONE OF THIS DOES JACK :) -- you already got this info
      # session[:f_name]      = contact_info["firstName"]
      # session[:l_name]      = contact_info["lastName"]
      # session[:email]       = contact_info["emailAddress"]
      # session[:headline]    = contact_info["headline"]
      # session[:provider]    = "LinkedIn"
    end

    def messages
      messages = HTTParty.post("https://api.linkedin.com/v1/people/~/mailbox",
        :headers => {
          "Authorization" => "Bearer #{session[:access_token]}"
          }
      )
          session[:recipients] = " "
          session[:person]     = " "
          session[:path]       = " "
          session[:subject]    = " "
          session[:body]       = " "
    end




  end #ends DatabaseHelper
end #ends User_Info
