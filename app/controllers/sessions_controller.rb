class SessionsController < ActionController::API

	def create
		session = SessionCreator.create(params[:code])
		user = UserCreator.create(session)
		ConnectionsProcessor.process(user)
		redirect_to "#{ENV['DOUGALL_EMBER_DOMAIN']}/#/friends-graph/#{user.id}"
	end

end
