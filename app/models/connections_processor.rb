class ConnectionsProcessor

	def initialize(user, updater: UserUpdateWorker)
		@updater = updater
		@access_token = user.access_token
		@connected_users = user.connected_users
	end

	def self.process(user)
		new(user).process
	end

	def process
		connected_users.each do |connected_user|
			updater.perform_async(connected_user.id, access_token)
		end
	end

	private

	attr_reader :connected_users, :updater, :access_token

end
