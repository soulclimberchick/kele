require 'httparty'
require 'json'
require_relative 'roadmap'

class Kele
  include HTTParty
	include Roadmap

 	base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
 		response = self.class.post(base_api_url("sessions"), body: { "email": email, "password": password })
 		raise "Invalid email or password" if response.code == 404
 		@auth_token = response["auth_token"]
 	end

 	def get_me
 		response = self.class.get(base_api_url("users/me"), headers: { "authorization" => @auth_token })
 		JSON.parse(response.body)
 	end
 
 	def get_mentor_availability(id)
 		response = self.class.get(base_api_url("mentors/#{id}/student_availability"), headers: { "authorization" => @auth_token })
 		JSON.parse(response.body)
 	end

 	private
 	def base_api_url(endpoint)
 		"https://www.bloc.io/api/v1/#{endpoint}"
 	end
 end
