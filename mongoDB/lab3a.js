use blogger

function insertUser(_id, name, email){db.users.insert({_id:_id,name:name,email:email});}

insertUser(ObjectId("5bb26043708926e438db6cad"), "Sally", "sally@uis.edu")
insertUser(ObjectId("5bb26043708926e438db6cae"), "Tom", "tom@uis.edu")
insertUser(ObjectId("5bb26043708926e438db6caf"), "Joe", "joe@uis.edu")

db.users.find().pretty()

db.users.find({"_id":ObjectId("5bb26043708926e438db6cad")})

function insertBlog(title, body, slug, author, comments, category){db.blogs.insert({title:title, body:body, slug:slug, author:author, comments:comments, category:category});}

insertBlog("Dancing 101", "Dancing is fun for everyone, and anyone can be a master.", "master-dancing", "Tom", [{_id:ObjectId("5bb26043708926e438db6caf"), comment:"Wow what a great article", approved:true, created_at:ISODate("2019-01-01")},{_id:ObjectId("5bb26043708926e438db6caf"),comment:"Maybe I'll try dancing", approved:false, created_at:ISODate("2019-01-02")}],[{name:"Joe"},{name:"Joe"}])

insertBlog("What I learned in school", "On the first day I learned to build a web page framework.", "learning-frameworks", "Sally", [{_id:ObjectId("5bb26043708926e438db6cae"), comment:"Can you teach me about frameworks sometime?", approved:true, created_at:ISODate("2019-02-01")},{_id:ObjectId("5bb26043708926e438db6caf"),comment:"Can you build a webpage for my friend?", approved:true, created_at:ISODate("2019-03-01")}],[{name:"Tom"},{name:"Joe"}])

insertBlog("How to make lasagna", "Buy lasagna at the store and heat in the microwave. It's that simple!", "cooking-lasagna", "Joe", [{_id:ObjectId("5bb26043708926e438db6cad"), comment:"I tried this and didn't like it.", approved:false, created_at:ISODate("2019-04-01")},{_id:ObjectId("5bb26043708926e438db6cae"),comment:"How long do you put it in the microwave?", approved:true, created_at:ISODate("2019-04-01")}],[{name:"Sally"},{name:"Tom"}])

db.blogs.find({'comments._id':ObjectId("5bb26043708926e438db6caf")},{_id:0,title:1,slug:1})

db.blogs.find({body:/framework/i},{_id:0,title:1,body:1})
