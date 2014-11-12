class User < ActiveRecord::Base

  has_many :sessions
  has_many :connections
  has_many :connected_users, through: :connections

  def serealize
  	user = attributes
  	user[:connected_users_ids] = connected_users.pluck(:id)
  	c_users = connected_users.map do |c_user|
  		c_user.attributes.merge({ user_id: id })
  	end
  	{ user: user, connected_users: c_users }.to_json
  end


# Distance Values are:

# 0: the member
# 1, 2, and 3: # of degrees apart
# -1: out of network
# 100: share a group, but not within 3 degrees (will get 1-3 instead)

end
