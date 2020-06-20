#!/usr/bin/env bash

#Add your curl statements here
curl -X PUT http://couchdb:5984/restaurants

curl -i -X POST http://couchdb:5984/restaurants -H "Content-Type: application/json" -d '{"_id": "chipotle", "name": "Chipotle", "food_type":["Mexican", "Fast Food", "Casual"], "phonenumber": 8001234567, "website":"chipotle.com"}'

curl -i -X POST http://couchdb:5984/restaurants -H "Content-Type: application/json" -d '{"_id": "torchys_tacos", "name": "Torchys", "food_type":["Mexican", "Fast Food", "Casual"], "phonenumber": 8001231234, "website":"torchys.com"}'

curl -i -X POST http://couchdb:5984/restaurants -H "Content-Type: application/json" -d '{"_id": "franklins_bbq", "name": "Franklins", "food_type":["BBQ", "American"], "phonenumber": 8009994567, "website":"franklinsbbq.com"}'


#DO NOT REMOVE
curl -Ssf -X PUT http://couchdb:5984/restaurants/_design/docs -H "Content-Type: application/json" -d '{"views": {"all": {"map": "function(doc) {emit(doc._id, {rev:doc._rev, name:doc.name, food_type:doc.food_type, phonenumber:doc.phonenumber, website:doc.website})}"}}}'
curl -Ssf -X GET http://couchdb:5984/restaurants/_design/docs/_view/all
