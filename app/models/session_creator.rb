class SessionCreator

	include Linkedin

	def initialize(code, session_mapper: Maps::Session, session_factory: Session)
		@code = code
		@session_mapper = session_mapper
		@session_factory = session_factory
	end

	def self.create(code)
		new(code).create
	end

	def create
		access_token = linkedin.client.exchange_token(code)
		map = session_mapper.new(access_token)
		session_factory.create(map.to_hash)
	end

	private

	attr_reader :code, :session_mapper, :session_factory

end
