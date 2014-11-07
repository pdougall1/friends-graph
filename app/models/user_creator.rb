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
		user = user_factory.where(linkedin_id: map.linkedin_id).first_or_create
		user.update_attributes(map.to_hash.except(:connections))
		session.update_attributes(user: user)
		persist_connections(map)
	end

	private

	attr_reader :session, :users_mapper, :user_factory

	def fields
		['email-address', 'id', 'first-name', 'last-name', 
		 'headline', 'industry', 'distance', 
		 'num-connections', 'public-profile-url', 
		 'connections', 'picture-url']
	end

	def persist_connections(map)
		map.connections.each do |conn|
			map = users_mapper.new(conn)
			user_factory.where(linkedin_id: map.linkedin_id).tap do |user|
				user.first_or_create.update_attributes(map.to_hash)
			end
		end
	end

end
