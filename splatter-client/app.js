(function() { // We use this anonymous function to create a closure.

	var app = angular.module('splatter-web', ['ngResource']);

	app.factory('User', function($resource)
	{
		return $resource('http://pickworth.sqrawler.com/api/users/:id.json', {},
		{
		'update': {method:'PUT', url: 'http://pickworth.sqrawler.com/api/users/:id'}
		'save': {method 'POST' , url: 'http://pickworth.sqrawler.com/api/users.json'}
		} );
	});


	app.controller('UserController', function(User)
	{
        // add your user code below
	this.data = {};
	this.ulist = User.query();
	this.getUser = function(i)
	{
		return User.get({id: i});
	};
//	this.feed = feed;
	// add your user code above	
	this.login = function()
	{
		this.loggedin_user = this.getUser(this.data.id);
		this.data = {};
	};

	});

	app.controller('UserCreate', function(User)
	{
	this.data {};

        // add your form controller below
/*	this.createUser = function()
	{
		u = new User();
		u.name = this.data.cname;
		u.email = this.data.cemail;
		u.password = this.data.cpassword;
		u.blurb = this.data.cblurb;
		u.$save();
		
		this.data = {};
	};
*/
	this.createUser = function()
	{
	user = new User(
		{name: this.data.name,
		email: this.data.email,
		password: this.data.password,
		blurb: this.data.blurb
		});
	user.save({user: user});
	};
	});


	app.controller('UserDelete',function(User)
	{
	this.updateUser = function()
	{
		this.loggedin_user.name = this.data.name;
		this.loggedin_user.email = this.data.email;
		this.loggedin_user.blurb = this.data.blurb;
		this.loggedin_user.$update();
		this.data = {};
	};

	this.deleteUser = function()
	{
		User.delete({id: this.user.id});
	};

	});

        // add your form controller above

	// mock data
/*       var u1 = {
          id: 1,
          name: "Jane Doe",
          email: "jane@doe.com",
          blurb: "Sometimes I feel anonymous."
	};	

        var u2 = {
          id: 2,
	  name: "Bob Smith",
	  email: "bob@smith.org"
	};*/
/*
	app.controller("UpdateFormController", function() {
		this.data = {};
		this.updateUser = function(user) {
			user.u.name = this.data.name;
			this.data = {}; //clears the form
			}
	});
*/

/*       var feed = [
         {
	   id: 3,
           user_id: 2,
           body: "This is Bob's most recent splatt.",
	   created_at: "2014-08-17T22:00:00Z"
	 },
         {
	   id: 2,
           user_id: 2,
           body: "This is Bob's second splatt.",
	   created_at: "2014-08-16T13:25:00Z"
         },
         {
	   id: 1,
           user_id: 2,
           body: "This is Bob's first splatt.",
	   created_at: "2014-08-16T10:25:00Z"
	 }
       ];*/
})();
