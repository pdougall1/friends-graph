class UserCreator

	include Linkedin

	def initialize(session, users_mapper: Maps::User, user_factory: User)
		@session = session
		@users_mapper = users_mapper
		@user_factory = user_factory
	end

	def self.create(session)
		new(session).create
	end

	def create
		user_data = linkedin.find('me', session.access_token, fields: fields)
		map = users_mapper.new(user_data)
		user = user_factory.create(map.to_hash.except(:connections))
		# TODO: add connections
	end

	private

	attr_reader :session, :users_mapper, :user_factory

	def fields
		['email-address', 'id', 'first-name', 'last-name', 
		 'headline', 'industry', 'distance', 
		 'num-connections', 'public-profile-url', 
		 'connections', 'picture-url']
	end

end
