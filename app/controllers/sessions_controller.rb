class SessionsController < ActionController::API

	def create
		session = SessionCreator.create(params[:code])
		user = UserCreator.create(session)
		head :ok
	end

end
