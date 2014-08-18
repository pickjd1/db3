echo .
echo Reset the database
rake db:reset
echo .
echo .
echo Please restart the rails server
echo .
echo .
echo Create 3 Users
echo .
echo .
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/users -d '{"user": {"email":"test1@foo.com", "name":"Test1 User1", "password":"P@ssw0rd"}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/users -d '{"user": {"email":"test2@foo.com", "name":"Test2 User2", "password":"P@ssw0rd"}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/users -d '{"user": {"email":"test3@foo.com", "name":"Test3 User3", "password":"P@ssw0rd"}}'
echo .
echo .
echo Create 5 Splatts for Each User
echo .
echo .
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello, Splatter world post 1", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Gday, Splatter world post 2", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Kia Ora, Splatter world post 3", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Bonjour, Splatter world post 4", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Gutentag, Splatter world post 5", "user_id":1}}'

curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello, Splatter world post 1", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Gday, Splatter world post 2", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Kia Ora, Splatter world post 3", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Bonjour, Splatter world post 4", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Gutentag, Splatter world post 5", "user_id":2}}'

curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello, Splatter world post 1", "user_id":2}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Gday, Splatter world post 2", "user_id":3}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Kia Ora, Splatter world post 3", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Bonjour, Splatter world post 4", "user_id":1}}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Gutentag, Splatter world post 5", "user_id":3}}'
echo .
echo .
echo User 1 Follows Users 2 and 3
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":2}'
curl -i -H "Content-type: application/json" -X POST http://pickworth.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":3}'
echo .
echo .
echo Gets User 1s splatts
curl -i -H "Content-type: application/json" -X GET http://pickworth.sqrawler.com:3000/users/splatts/1
echo .
echo .
echo Gets Users followed by User 1
curl -i -H "Content-type: application/json" -X GET http://pickworth.sqrawler.com:3000/users/followers/1
echo .
echo .
echo Gets User 1s newsfeed
curl -i -H "Content-type: application/json" -X GET http://pickworth.sqrawler.com:3000/users/splatts_feed/1
echo .
echo .
echo Deletes User 1 from the followers of User 3
curl -i -H "Content-type: application/json" -X DELETE http://pickworth.sqrawler.com:3000/users/follows/1/3
echo .
echo .
echo Gets User 1s newsfeed after unfollowing User 3
curl -i -H "Content-type: application/json" -X GET http://pickworth.sqrawler.com:3000/users/splatts_feed/1
echo .
echo .
echo Script is Finished Running