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
    response = self.class.get('/users/me', headers: { "authorization" => @auth })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    mentor_url = "https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability"
    response = self.class.get(mentor_url, headers: {"content_type" => "application/json", "authorization" => @auth_token})
    body = JSON.parse(response.body)
  end
end
