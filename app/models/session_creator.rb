class SessionCreator

	def initialize(code, session_mapper: Maps::Session, session_factory: Session)
		@code = code
		@session_mapper = session_mapper
		@session_factory = session_factory
	end

	def self.create(code)
		new(code).create
	end

	def create
	end

	private

	attr_reader :code, :session_mapper, :session_factory

end