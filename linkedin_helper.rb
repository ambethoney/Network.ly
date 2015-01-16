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
          name:       contact["firstName"] + " " + contact["lastName"],
          url:        url,
          encodedUrl: URI.encode_www_form_component(url),
          api_name:   api_name
        }
      end

      # Retrieves:
      # firstName
      # headline
      # lastName
      # TODO: Figure out why email isn't included.
    end

    def get_contact_info(access_token, api_name)
      # TODO: linkedin api for specific user
      # set request fields picture-url
      url        = "https://api.linkedin.com/v1/people/#{api_name}"
      req_fields = ":(picture-url,formatted-name,email-address,headline)"
      headers    = {"Authorization" => "Bearer #{access_token}"}
      request = HTTParty.get(url + req_fields, headers: headers)
      request["person"]
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

    # def api_get_call(url,access_token)
    #   request = HTTParty.get(url, headers: {"Authorization" => "Bearer #{access_token}"})
    # end

  end #ends DatabaseHelper
end #ends User_Info
