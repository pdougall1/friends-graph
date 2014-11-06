class Maps::Session < Hashie::Trash

	property :access_token
	property :expiration, from: :expires_in, with: -> (expires_in) { expiration_date(expires_in) }

	def initialize(params={})
		super(params.with_indifferent_access.slice(*(self.class.permitted_input_keys)).symbolize_keys)
	end

	def to_hash
		each_key.reduce({}) do |acc, key|
			acc[key] = self.send(key)
			acc
		end
	end

	private

	def self.expiration_date(expires_in)
		expires_in = expires_in.to_i if expires_in.is_a? String
		Time.now + expires_in
	end

end