class SessionsController < ActionController::API

	def create
		session = SessionCreator.create(params[:code])
		head :ok
	end

end
