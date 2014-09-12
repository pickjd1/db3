(function() { // We use this anonymous function to create a closure.

	var app = angular.module('splatter-web', ['ngResource']);

	app.factory('User', function($resource, $http) 
	{
		return $resource('http://pickworth.sqrawler.com/api/users/:id.json',{},
		{
			update: {method:'PUT'},
			follow: {method:'POST', url:'http://pickworth.sqrawler.com/api/users/follows/:id'},
			addsplatt: {method:'POST', url:'http://pickworth.sqrawler.com/api/splatts/'},
			unfollow: {method:'DELETE', url:'http://pickworth.sqrawler.com/api/users/follows/:id/:follows_id'}
		})
	});
	
	app.factory('SplattsFeed', function($resource) 
	{
		return $resource('http://pickworth.sqrawler.com/api/users/splatts-feed/:id.json',{},
		{
			getsplatts: {method:'GET',url:'http://pickworth.sqrawler.com/api/users/splatts/:id.json', isArray:true}
		});
	});

	app.controller('UserController', function(User, SplattsFeed) 
	{
		this.data = {};
		this.ulist = User.query();
		this.getUser = function(i)
		{
			return User.get({id: i});
		};
	});
	
	
		app.controller("UpdateFormController", function(User, SplattsFeed) 
	{
		this.data = {};
		this.updateUser = function(user) 
		{			
			newUser = User.get({id: this.data.name});
			newFeed = SplattsFeed.get({id: this.data.name});
			user.u = newUser;
			user.feed = newFeed;
			this.data = {} //clears the form
		}
	});	
	
	app.controller("createUserController", function(User, $http) 
	{
		this.data = {};
		this.newUser = function(user) 
		{	
			postData = {"user":{
  				"email": this.data.email, 
  				"name": this.data.name, 
				"password": this.data.password,
  				"blurb": this.data.blurb 
			}}
			
			User.save(postData);
			this.data = {} //clears the form
		}
	});	
	
	app.controller("ShowSplattsController", function(User, SplattsFeed) 
	{
		this.data = {};
		this.updateFeed = function(user) 
		{			
			SplattsFeed.getsplatts({id: this.data.id})
			.$promise.then
			(function(value){user.feed.splatt = value});
			this.data = {} //clears the form}
				
		}
	});	

	
	app.controller("DeleteUserController", function(User) 
	{
		this.data = {};
		this.deleteUser = function(user) 
		{	
			deleteId = this.data.id;			
			User.delete({id: deleteId});
			this.data = {} //clears the form
		}
	});	

	app.controller("UpdateUserController", function(User) 
	{	
		this.data = {};
		this.updateUser = function(user) 
		{	
			postData = 
			{"user":
				{
					"name": this.data.name, 
					"blurb": this.data.blurb 
				}
			}

			User.update({id: user.u.id},postData);
			this.data = {} //clears the form
		}
	}
	);
	
	app.controller("AddSplattController", function(User) 
	{	
		this.data = {};
		this.addSplatt = function(user) 
		{	
			postData = 
			{"splatt":
				{
					"body": this.data.splatt, 
					"user_id": user.u.id 
				}
			}
			User.addsplatt({},postData);
			this.data = {} //clears the form
		}
	});
	
		app.controller("FollowUserController", function(User) 
	{	
		this.data = {};
		this.followUser = function(user) 
		{	
			followUserData = {"id": user.u.id,"follows_id": this.data.follows}
			User.follow({},followUserData);
			this.data = {} //clears the form
		}
	});
	
		app.controller("UnfollowUserController", function(User) 
	{	
		this.data = {};
		this.unfollowUser = function(user) 
		{	
			User.unfollow({id: user.u.id,follows_id: this.data.follows},{});
			this.data = {} //clears the form
		}
	});
})(); 