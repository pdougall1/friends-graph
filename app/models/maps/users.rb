class Maps::Users < Hashie::Trash

	property :access_token, from: :accessToken
	property :facebook_id, from: :userID
	property :expiration, from: :expiresIn, with: -> (expires_in) { expiration_date(expires_in) }

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