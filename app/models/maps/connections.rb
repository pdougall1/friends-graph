class Maps::Connections < Hashie::Trash

	def initialize(params={})
		super(params.with_indifferent_access.slice(*(self.class.permitted_input_keys)).symbolize_keys)
	end

end
