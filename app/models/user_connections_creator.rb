class UserConnectionsCreator

	include Facebook

	def initialize(user, connections_map: Maps::Connections, user_klass: User)
		@user = user
		@connections_map = connections_map
		@user_klass = user_klass
	end

	def find_or_create
		connecitons_data = fb_graph.get_object("#{user.facebook_id}/friends")
		map = connections_map.new()
		map.connections.each do |connection|
			user_klass.transaction do
				connected_user = user_klass.where(facebook_id: connection.facebook_id)
					.first_or_create
					.tap { |conn| conn.update_attributes(connection) }
				user.connections.build(connected_user_id: connected_user.id).save
			end
		end	
	end

	private 

	attr_reader :user, :connections_map, :user_klass

	def fb_graph
		@fb_graph ||= fb(user)
	end

end
