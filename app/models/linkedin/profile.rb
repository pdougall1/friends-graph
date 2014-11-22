class Linkedin::Profile

	FIELDS = ['email-address', 'id', 'first-name', 'last-name', 
		 'headline', 'industry', 'distance', 
		 'num-connections', 'public-profile-url', 
		 'connections', 'picture-url', 'picture-urls::(original)']

	def self.fields
		FIELDS
	end

end