class Linkedin::Client

	include Singleton

	attr_reader :faraday

	def initialize
		@faraday = Faraday
	end

	def self.exchange_token(code)
		response = instance.connection.post do |req|
		  req.url instance.access_token_exchange_url
		  req.params['grant_type'] = 'authorization_code'
		  req.params['code'] = code
		  req.params['redirect_uri'] = 'https://localhost:5000/sessions/linkedin'
		  req.params['client_id'] = ENV['LINKEDIN_API_KEY']
		  req.params['client_secret'] = ENV['LINKEDIN_SECRET_KEY']
		end
		response.body
	end

	def connection
		@connection ||= Faraday.new(:url => domain) do |faraday|
		  faraday.request  :url_encoded             # form-encode POST params
		  faraday.response :logger                  # log requests to STDOUT
		  faraday.response :json, content_type: /\bjson$/
		  faraday.adapter Faraday.default_adapter
		end 	
	end

	def domain
		'https://www.linkedin.com'
	end

	def access_token_exchange_url
		'/uas/oauth2/accessToken'
	end

end
