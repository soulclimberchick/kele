require './lib/kele'
require 'httparty'

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
end
