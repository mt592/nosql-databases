curl -v -X PUT http://riak:8098/riak/movies/TheDarkKnight -H "Content-Type:application/json" -d '{"releasedate":"2008", "runningtime":"2:32", "genre":"action"}'

curl -v -X PUT http://riak:8098/riak/movies/Inception -H "Content-Type:application/json" -d '{"releasedate":"2010", "runningtime":"2:28", "genre":"action"}'

curl -v -X PUT http://riak:8098/riak/movies/LifeIsBeautiful -H "Content-Type:application/json" -d '{"releasedate":"1997", "runningtime":"1:56", "genre":"drama"}'

curl -v -X PUT http://riak:8098/riak/movies/ForrestGump -H "Content-Type:application/json" -d '{"releasedate":"1994", "runningtime":"2:22", "genre":"drama"}'

curl -v -X PUT http://riak:8098/riak/movies/WallE -H "Content-Type:application/json" -d '{"releasedate":"2008", "runningtime":"1:38", "genre":"animation"}'

curl -v -X PUT http://riak:8098/riak/movies/TheLionKing -H "Content-Type:application/json" -d '{"releasedate":"1994", "runningtime":"1:28", "genre":"animation"}'

curl -X DELETE http://riak:8098/riak/movies/WallE

curl -X PUT http://riak:8098/riak/branches/West -H "Content-Type:application/json" -H "Link:</riak/movies/TheDarkKnight>; riaktag=\"holds\", </riak/movies/LifeIsBeautiful>; riaktag=\"holds\"" -d '{"name":"West"}'

curl -X PUT http://riak:8098/riak/branches/East -H "Content-Type:application/json" -H "Link:</riak/movies/TheDarkKnight>; riaktag=\"holds\", </riak/movies/TheLionKing>; riaktag=\"holds\", </riak/movies/ForrestGump>; riaktag=\"holds\"" -d '{"name":"East"}'

curl -X PUT http://riak:8098/riak/branches/South -H "Content-Type:application/json" -H "Link:</riak/movies/Inception>; riaktag=\"holds\"" -d '{"name":"South"}'


curl -X PUT http://riak:8098/riak/images/lionking.jpeg -H "Content-Type:image/jpeg" -H "Link:</riak/movies/TheLionKing>; riaktag=\"photo\"" --data-binary @lionking.jpeg

curl -X GET http://riak:8098/riak?buckets=true

curl http://riak:8098/riak/branches/East/_,_,_
curl http://riak:8098/riak/branches/West/_,_,_
curl http://riak:8098/riak/branches/South/_,_,_

curl http://riak:8098/riak/branches/East/_,_,_
curl http://riak:8098/riak/images/lionking.jpeg/_,_,_
