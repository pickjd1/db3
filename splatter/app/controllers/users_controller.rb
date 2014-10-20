class UsersController < ApplicationController
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # GET /users
  # GET /users.json


 def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params(params))

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params(params))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end




  def splatts
	@user = User.find(params[:id])
	render json: @user.splatts
  end  

def show_follows
   @user = User.find(params[:id])

	render json: @user.follows
end


def show_followers
  @user = User.find(params[:id])

	render json: @user.followed_by
end

def add_follows
	
	
	@user = User.find(params[:id])
	
	@follows = User.find(params[:follows_id])
	
	if @user.follows << @follows and @follows.followers << @user
		render json: @user.follows
	else
		render json: @follower.errors, status: :unprocessable_entity
	end
end


def delete_follows
	@user = User.find(params[:id])
	@follows = User.find(params[:follows_id])

	@follows.followers.delete(@follows)
	head :no_content
		
end	

def splatts_feed
  map = %Q{
	function(){
		if(this.splatts) {
			var owner = this;
			var splatts = this.splatts;
			splatts.forEach(function(item){
					item.owner = owner._id;
			});
			emit ("feed",{"list":splatts});
			}
		}
	}

  reduce = %Q{
	function(key, values){
		var feed = {"list": []};
			values.forEach(function(v) {
				feed.list = feed.list.concat(v.list);
			});
			return feed;
		}
	}

  finalize  = %Q{
	function(key, val) {
		var myList = val.list;
			if(myList) {
				myList.sort(function(a, b) {
					return b.updated_at - a.updated_at;
					});
				}
			return myList;
			}
	}
    @user = User.find(params[:id])
    @result = User.any_of({:id.in => @user.follow_ids}, {:id => @user.id}).map_reduce(map, reduce).out({inline: true}).finalize(finalize)
    if @result.entries[0]
      @feed = @result.entries[0][:value]
    else
      render json: @result
    end
end

private
  def user_params(params)
	  logger.info "params:  #{params}"
          params.permit(:id, :name, :email, :password, :blurb)
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
