class SessionsController < ActionController::API

	def create
		puts "PARAMS : #{params}"
		head :ok
	end

end
