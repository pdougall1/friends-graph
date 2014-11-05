class Facebook::Connection

	include Singleton

	def self.graph(access_token)
		Koala::Facebook::API.new(access_token)
	end
end