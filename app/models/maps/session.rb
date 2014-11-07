class Maps::Session < Hashie::Map

	property :access_token
	property :expiration, from: :expires_in, with: -> (expires_in) { expiration_date(expires_in) }

	private

	def self.expiration_date(expires_in)
		expires_in = expires_in.to_i if expires_in.is_a? String
		Time.now + expires_in
	end

end