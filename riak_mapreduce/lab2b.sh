#Load the data into Riak 
./lab2b/load_data.erl ./lab2b/goog.csv

#Return the entire data set
curl -vSsf -X POST http://riak:8098/mapred -H 'Content-Type: application/json' -d \
'{"inputs":"goog",
"query":[{"map":{"language":"javascript",
"name":"Riak.mapValuesJson",
"keep":true}}]}'

curl -X POST http://riak:8098/mapred -H "Content-Type:application/json" -d '{"inputs":"goog", "query":[{"map":{"language":"javascript", "source":"function(value, keyData, arg){ var data = Riak.mapValuesJson(value)[0]; if (data.Low && data.Low < 450.00) return [value.key]; else return [];}", "keep":true}}]}'

curl -X POST http://riak:8098/mapred -H "Content-Type:application/json" -d '{"inputs":"goog", "query":[{"map":{"language":"javascript", "source":"function(value, keyData, arg){ var data = Riak.mapValuesJson(value)[0]; if (data.Close < data.Open) return [value.key]; else return [];}", "keep":true}}]}'

