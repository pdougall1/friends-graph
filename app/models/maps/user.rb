class Maps::User < Hashie::Trash

	property :first_name, from: :firstName
	property :last_name, from: :lastName
	property :email, from: :emailAddress
	property :linkedin_id, from: :id
	property :headline
	property :industry
	property :distance
	property :connections, transform_with: -> (c) { c['values'] }
	property :num_connections, from: :numConnections
	property :linkedin_profile_url, from: :publicProfileUrl
	property :picture_url, from: :pictureUrl
	

	def initialize(params={})
		super(params.with_indifferent_access.slice(*(self.class.permitted_input_keys)).symbolize_keys)
	end

	def to_hash
		each_key.reduce({}) do |acc, key|
			acc[key] = self.send(key)
			acc
		end
	end
end