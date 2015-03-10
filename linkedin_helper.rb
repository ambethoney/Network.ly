module ProjectDashboard
  module LinkedinHelper

    def user_info(access_token)
      response = HTTParty.get("https://api.linkedin.com/v1/people/~:(first-name,last-name,email-address)?format=json",
      :headers => {
        "Authorization" => "Bearer #{access_token}"
        })
      return {
        :email_address => response["emailAddress"],
        :first_name    => response["firstName"],
        :last_name     => response["lastName"]
      }
    end

    def get_contacts(access_token)
      response = HTTParty.get("https://api.linkedin.com/v1/people/~/connections:(headline,first-name,last-name,api-standard-profile-request:(url))?format=json",
      :headers => {
        "Authorization" => "Bearer #{access_token}"
      })
      contacts = response["values"]

      # remove private contacts from contact list
      contacts.reject! {|contact| contact["firstName"] == "private"}

      # reformat the contact list
      contacts.map do |contact|
        url = contact["apiStandardProfileRequest"]["url"]
        api_name = url.split('/').last
        {
          name:        contact["firstName"] + " " + contact["lastName"],
          headline:    contact["headline"],
          picture_url: contact["picture-url"],
          url:         url,
          encodedUrl:  URI.encode_www_form_component(url),
          api_name:    api_name
        }

      end #ends map contacts

      #push headlines into an array
      # @contact_headlines = contacts.map do |job|
      #   binding.pry
      #   job["headline"]
      # end #ends contacts-headlines
    end #ends get contacts

    def get_contact_info(access_token, api_name)

      url        = "https://api.linkedin.com/v1/people/#{api_name}"
      req_fields = ":(picture-url,formatted-name,email-address,headline)"
      headers    = {"Authorization" => "Bearer #{access_token}"}
      request    = HTTParty.get(url + req_fields, headers: headers)
      request["person"]

    end


# def send_message(subject, body, recipient_paths)
#         path = "/people/~/mailbox"

#         message = {
#             'subject' => subject,
#             'body' => body,
#             'recipients' => {
#                 'values' => recipient_paths.map do |profile_path|
#                   { 'person' => { '_path' => "/people/#{profile_path}" } }
#                 end
#             }
#         }
#         post(path, MultiJson.dump(message), "Content-Type" => "application/json")
#       end





    #   messages = HTTParty.post("https://api.linkedin.com/v1/people/~/mailbox",
    #     :headers => {
    #       "Authorization" => "Bearer #{session[:access_token]}"
    #       "Accept"        => "application/json"
    #       }
    #   )
    #  session[:recipients] = " "
    #  session[:person]     = " "
    #  session[:path]       = " "
    #  session[:subject]    = " "
    #  session[:body]       = " "
    # end

    # def api_get_call(url,access_token)
    #   request = HTTParty.get(url, headers: {"Authorization" => "Bearer #{access_token}"})
    # end

  end #ends DatabaseHelper
end #ends User_Info
