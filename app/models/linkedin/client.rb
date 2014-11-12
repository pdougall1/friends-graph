class Linkedin::Client

	include Singleton

	attr_reader :faraday

	def initialize
		@faraday = Faraday
	end

	def self.exchange_token(code)
		instance.exchange_token(code)
	end

	def self.find(query_params, access_token, fields: fields)
		instance.find(query_params, access_token, fields: fields)
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

	def find(query_params, access_token, fields: fields)
		@domain = 'https://api.linkedin.com'
		response = connection.get do |req|
		  req.url path(query_params, fields)
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

	def path(query_params, fields)
		path = send(query_params[:query_type].to_sym)
		path += "/id=#{query_params[:linkedin_id]}" if query_params[:linkedin_id]
		add_fields(path, fields)
	end

	def add_fields(url, fields)
		"#{url}:(#{fields.join(',')})"
	end

	def access_token_exchange_url
		'/uas/oauth2/accessToken'
	end

	def people
		'/v1/people'
	end

	def me
		"#{people}/~"
	end

end
