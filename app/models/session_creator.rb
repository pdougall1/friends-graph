class SessionCreator

	def initialize(params, sessions_map: Maps::Sessions, session_klass: Session)
		@session_klass = session_klass
		@sessions_map = sessions_map
		@params = params
	end

	def find_or_create
		map = sessions_map.new(params)
		map_hash = map.to_hash
		map_hash[:active] = true
		session_klass.where(facebook_id: map.facebook_id)
			.first_or_create
			.tap { |session| session.update_attributes(map_hash) }
	end

	private

	attr_reader :sessions_map, :params, :session_klass

end