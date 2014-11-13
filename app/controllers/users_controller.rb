class UsersController < ActionController::API

	def show
		if user = User.find(params[:id])
			render json: user.serealize
		else
			head :ok
		end
	end

end
