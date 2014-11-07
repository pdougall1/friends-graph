class UsersController < ActionController::API

	def show
		user = User.find(params[:id])
		render json: user.serealize
	end

end
