class Linkedin::Client

	include Singleton

	attr_reader :faraday

	def initialize
		@faraday = Faraday
	end

	def self.exchange_token(code)
		instance.exchange_token(code)
	end

	def self.find(query_type, access_token)
		instance.find(query_type, access_token)
	end

	def exchange_token(code)
		@domain = 'https://www.linkedin.com'
		response = connection.post do |req|
		  req.url access_token_exchange_url
		  req.params['grant_type'] = 'authorization_code'
		  req.params['code'] = code
		  req.params['redirect_uri'] = 'https://localhost:5000/sessions/linkedin'
		  req.params['client_id'] = ENV['LINKEDIN_API_KEY']
		  req.params['client_secret'] = ENV['LINKEDIN_SECRET_KEY']
		end
		response.body
	end

	def find(query_type, access_token)
		@domain = 'https://api.linkedin.com'
		response = connection.get do |req|
		  req.url send(query_type.to_sym)
		  req.headers['x-li-format'] = "json"
		  req.headers['Authorization'] = "Bearer #{access_token}"
		end
		response.body
	end

	def connection
		@connection = faraday.new(:url => @domain) do |config|
		  config.request  :url_encoded             # form-encode POST params
		  config.response :xml,  content_type: /\bxml$/
		  config.response :json, content_type: /\bjson$/
		  config.adapter faraday.default_adapter
		end 	
	end

	def access_token_exchange_url
		'/uas/oauth2/accessToken'
	end

	def person_url
		'/v1/people'
	end

	def me
		"#{person_url}/~"
	end

end
