require './lib/kele'
require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post('/sessions', body: { email: email, password: password })

    @auth = response['auth_token']
    if @auth == nil
      puts 'Invalid Credentials'
    else
      puts 'Welcome'
    end
  end

  def get_me
 		response = self.class.get(base_api_url("users/me"), headers: { "authorization" => @auth_token })
 		JSON.parse(response.body)
 	end

  def get_mentor_availability(id)
 		response = self.class.get(base_api_url("mentors/#{id}/student_availability"), headers: { "authorization" => @auth_token })
 		JSON.parse(response.body)
 	end
end
