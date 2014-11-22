class UserUpdateWorker
  include Sidekiq::Worker
  include Linkedin

  def initialize(users_mapper: Maps::User)
  	@users_mapper = users_mapper
  end

  def perform(user_id, access_token = nil)
  	user = User.find(user_id)
  	@access_token = access_token || user.access_token
    profile = get_profile(user)
    map = users_mapper.new(profile)
		user.update_attributes(map.to_hash.except(:connections)) if profile
  end

  private

  attr_reader :users_mapper, :access_token

	def get_profile(user)
		query_params = { query_type: 'people', linkedin_id: user.linkedin_id }
		linkedin.client.find(query_params, access_token, fields: linkedin.profile.fields)
	end

end


