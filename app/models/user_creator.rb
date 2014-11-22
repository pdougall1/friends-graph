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
		query_params = { query_type: 'me' }
		user_data = linkedin.client.find(query_params, session.access_token, fields: fields)
		map = users_mapper.new(user_data)
		user = user_factory.where(linkedin_id: map.linkedin_id).first_or_create
		user.update_attributes(map.to_hash.except(:connections))
		session.update_attributes(user: user)
		persist_connections(user, map)
		user
	end

	private

	attr_reader :session, :users_mapper, :user_factory

	def persist_connections(user, map)
		map.connections.each do |conn|
			map = users_mapper.new(conn)
			new_user = user_factory.where(linkedin_id: map.linkedin_id).first_or_create
			new_user.update_attributes(map.to_hash)
			unless user.connected_users.include? new_user
				user.connections.create(connected_user_id: new_user.id)
			end
		end
	end

end
