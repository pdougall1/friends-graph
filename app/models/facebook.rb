module Facebook

	def fb(user)
		Connection.graph(user.access_token)
	end

end