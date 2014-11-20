class UserRepository
BUCKET = 'users'

# sets up our connection to the Riak db
def initialize(client)
	@client = client
end


def all
  keys = @client.bucket(BUCKET).keys
  riak_list = @client.bucket(BUCKET).get_many(keys)
  results = []
  riak_list.values.each do |splatt_obj|
	splatt = Splatt.new
	splatt.id = splatt_obj.data['id']
	splatt.body = splatt_obj.data['body']
	splatt.created_at = splatt_obj.data['created_at']
	results.push(splatt)
	end
results
end


def delete(user)

end


def find(key)
  riak_obj = @client.bucket(BUCKET)[key]
  user = User.new
  user.email = riak_obj.data['email']
  user.name = riak_obj.data['name']
  user.password = riak_obj.data['password']
  user.blurb = riak_obj.data['blurb']
  user.follows = riak_obj.data['follows']
  user.followers = riak_obj.data['followers']
  user
end


def save(user)
  users = @client.bucket(BUCKET)
  key = user.email

	unless users.exists?(key)
	  riak_obj = users.new(key)
	  riak_obj.data = user
	  riak_obj.content_type = 'application/json'
	  riak_obj.store
	end
end


def update(user)

end

def follow(follower,followed)
	if follower.follows
		follower.follows << followed.email
	else
		follower.followed = [followed.email]
	end

	if followed.followers
		followed.followers << follower.email
	else
		followed.followers = [follows.email]
	end

	update(followed)
	update(follower)
end

def delete_follow(follower,followed)
	follower.follows.delete
	followed.followers.delete

	update(followed)
	update(follower)
end

end
