module Messaging
	def get_messages(page = nil)

		if page == nil
			response = self.class.get(base_api_url("message_threads"), headers: { "authorization" => @auth_token })
		else
			response = self.class.get(base_api_url("message_threads?page=#{page}"), headers: { "authorization" => @auth_token })
		end

		JSON.parse(response.body)
	end

 	def create_message(sender_email, recipient_id, subject, body)
		response = self.class.post(base_api_url("messages"),
    body: {
			"sender" => sender_email,
			"recipient_id" => recipient_id,
			"subject" => subject,
			"stripped-text" => body,
      "token" => token
		},
		headers: { "authorization" => @auth_token })
	end
end
