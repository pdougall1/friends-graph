class SessionsController < ApplicationController

  def create
  	session     = SessionCreator.new(response_params).find_or_create
  	user        = UserCreator.new(session).find_or_create
    connections = UserConnectionsCreator.new(user).find_or_create
  	if session && user && connections
  		head :ok
  	else
  		head :not_found
  	end
  end

  def destroy
    # TODO
  end

  private 

  def response_params
  	params.require(:response).permit!
  end

end