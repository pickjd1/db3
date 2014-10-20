class SplattsController < ApplicationController
  # GET /splatts
  # GET /splatts.json
  def index
    @splatts = Splatt.all

    render json: @splatts
  end

  # GET /splatts/1
  # GET /splatts/1.json
  def show
    @splatt = Splatt.find(params[:id])

    render json: @splatt
  end

  # POST /splatts
  # POST /splatts.json
  def create
    @user = User.find(params[:user_id])
    splatt = Splatt.new({:body => params[:body]})

    if @user.splatts.push(splatt)
      render json: splatt, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /splatts/1
  # DELETE /splatts/1.json
  def destroy
    @splatt = Splatt.find(params[:id])
    @splatt.destroy

    head :no_content
  end

def count
    map = %Q{ function() {
                var length = 0;
                if(this.splatts) {
        	   length = this.splatts.length;
	        }
	        emit ("count", length);
	      }
	    }
    reduce  = %Q{ function(key, val) {
  		    var data = 0;
  		    val.forEach(function(v) {
  		      data += v;
		    });
		    return data
	  	  }
	        }
    @result = User.map_reduce(map, reduce).out(inline: true)
  
    render json: @result
end

end



private
  def splatts_params(params)
	params.permit(:body, :user_id)
  end
