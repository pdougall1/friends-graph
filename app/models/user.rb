class User < ActiveRecord::Base

	has_many :sessions
  has_many :connections
  has_many :connected_users, through: :connections


# Distance Values are:

# 0: the member
# 1, 2, and 3: # of degrees apart
# -1: out of network
# 100: share a group, but not within 3 degrees (will get 1-3 instead)

end