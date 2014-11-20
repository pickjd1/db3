class UsersController < ApplicationController
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # GET /users
  # GET /users.json


 def index
  db = UserRepository.new(Riak::Client.new) 
   
   @users = db.all

    render json: @users
  end

   #GET /users/1
  # GET /users/1.json
  def show
    db = UserRepository.new(Riak::Client.new)
    @users = db.find(params[:id])

    render json: @users
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new
    @user.email = params[:email]
    @user.name = params[:name]
    @user.password = params[:password]
    @user.blurb = params[:blurb]

    db = UserRepository.new(Riak::Client.new)
    if db.save(@user)
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    db = UserRepository.new(Riak::Client.new)
    @user = db.find(params[:id])

    if @user.update(user_params(params[:user]))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    db = UserRepository.new(Riak::Client.new)

    @user = db.find(params[:id])
    @user.destroy

    head :no_content
  end




  def splatts
	@user = User.find(params[:id])
	render json: @user.splatts
  end


def splatts_feed
  @feed = Splatt.find_by_sql ("SELECT splatts.body, splatts.user_id, splatts.id, splatts.created_at FROM splatts JOIN follows ON follows.followed_id=splatts.user_id WHERE follows.follower_id=#{params[:id]} ORDER BY created_at DESC")

  render json: @feed
end





def show_follows
   db = UserRepository.new(Riak::Client.new)
   @user = db.find(params[:id])

	render json: @user.follows
end


def show_followers
   db = UserRepository.new(Riak::Client.new)
   @user = db.find(params[:id])

	render json: @user.followed_by
end




def add_follows 

	db = UserRepository.new(Riak::Client.new)
	@follower = db.find(params[:id])
	@followed = db.find(params[:id])
	
	if 
		db.follow(@follower,@followed)
		head :no_content
	else
		render json: "Error Saving follow relationship", status: :unprocessable_entity
	end
end


def delete_follows

	db = UserRepository.new(Riak::Client.new)

	@follower = db.find(params[:id])
	@followed = db.find(params[:id])

	db.delete_follows(@follower, @followed)
	head :no_content
		
end	


private
  def user_params(params)
    params.permit(:email, :password, :name, :blurb)
  end

  def set_headers
	  headers['Access-Control-Allow-Origin'] = '*'
  end

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
          headers['Access-Control-Max-Age'] = '1728000'
  end
  
  #                   # If this is a preflight OPTIONS request, then short-circuit the
  #                     # request, return only the necessary headers and return an empty
  #                       # text/plain.
  #
  def cors_preflight_check
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
          headers['Access-Control-Max-Age'] = '1728000'
  end

end
