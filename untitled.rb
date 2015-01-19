def send_messages(access_token)
      url        = "https://api.linkedin.com/v1/people/~/mailbox"
      message = {
        'subject' => subject,
        'body' => body,
        'recipients' =>{
          'values' =>{
        },
        :headers    => {"Authorization" => "Bearer #{access_token}",
                    "Accept"        => "application/json"}
        }

      request = HTTParty.post(url + req_fields, headers: headers)
      binding.pry
      request["path"]
    end
