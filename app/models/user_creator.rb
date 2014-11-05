class UserCreator

	include Facebook

	def initialize(session, users_map: Maps::Users, user_klass: User)
		@session = session
		@users_map = users_map
		@user_klass = user_klass
	end

	def find_or_create
		user_data = fb_graph.get_object("me")
		map = users_map.new(user_data)
		user_klass.where(facebook_id: session.facebook_id)
			.first_or_create
			.tap do |user| user.update_attributes(map)
				session.update_attributes(user: user)
			end
	end

	private

	attr_reader :session, :users_map, :user_klass

	def fb_graph
		@fb_graph ||= fb(session)
	end

	def add_photo
		# TODO: ex: .get_picture("koppel")
	end

end
