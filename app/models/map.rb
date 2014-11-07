class Hashie::Map < Hashie::Trash

	def initialize(params={})
		super(params.with_indifferent_access.slice(*(self.class.permitted_input_keys)).symbolize_keys)
	end

	def to_hash
		each_key.reduce({}) do |acc, key|
			acc[key] = self.send(key)
			acc
		end
	end

end