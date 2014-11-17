class PingsController < ActionController::API

	def index
		puts "JUST GOT PINGED"
		head :ok
	end

end