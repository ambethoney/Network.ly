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
          })
        session[:email_address]  = response["emailAddress"]
        session[:first_name]     = response["firstName"]
        session[:last_name]      = response["lastName"]
        # session[:provider]     = "LinkedIn"
      end

    def get_contact_info
      contact_info = HTTParty.get("https://api.linkedin.com/v1/people/~/connections:(headline,first-name,last-name,email-address)?format=json",
      :headers => {
        "Authorization" => "Bearer #{session[:access_token]}"
      })
binding.pry
      @contact_f_name       = contact_info["values"]["firstName"]
      @contact_l_name       = contact_info["values"]["lastName"]
      @contact_email        = contact_info["values"]["emailAddress"]
      @contact_headline     = contact_info["values"]["headline"]

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
