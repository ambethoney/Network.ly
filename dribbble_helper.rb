module ProjectDashboard
  module DribbbleHelper

    def dribbble_user_info(session[:access_token])
       @api_name   = session[:access_token]
       url        = "https://api.dribbble.com/v1/user?access_token="
       headers    = {"Authorization" => "Bearer #{session[:access_token]}"}
       response   = HTTParty.get(url + api_name)

    end


  end #ends DribbbleHelper
end #ends ProjectDashboard
