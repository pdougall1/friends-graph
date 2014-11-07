class Maps::User < Hashie::Map

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
	
end