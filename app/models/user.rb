class User < ActiveRecord::Base

	has_many :sessions
	has_many :connections
	has_many :connected_users, through: :connections

	def active_session
		sessions.where(active: true).first
	end

	def access_token
		active_session.access_token
	end

end
