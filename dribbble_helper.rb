module ProjectDashboard
  module DribbbleHelper

    def dribbble_user_info(access_token)
      # ^ should be session[:access_token]
       api_name   = session[:dribbble_access_token]
       url        = "https://api.dribbble.com/v1/user?access_token="
       headers    = {"Authorization" => "Bearer #{session[:dribbble_access_token]}"}
       response   = HTTParty.get(url + api_name)

    end


  end #ends DribbbleHelper
end #ends ProjectDashboard
