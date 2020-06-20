//Your Neo4j code goes here
CREATE (ej:Family { name: 'Emmet', born: 1975}),

(ss:Family {name: 'Sally', born: 1970}),

(aj:Family {name: 'Andrew', born: 1970}),

(pj:Family {name: 'Peter', born: 2000}),

(dj: Family {name: 'Dave', born: 2002}),

(mp: Family {name: 'Mandy', born: 1975}),

(jp: Family {name: 'John', born: 1975}),

(ap: Family {name: 'Allison', born: 1999}),

(ss)-[:Spouse {married:[1990]}]-> (aj),

(pj)-[:Child {type:['son']}]-> (aj),

(pj)-[:Child {type:['son']}]-> (ss),

(dj)-[:Child {type:['son']}]-> (aj),

(dj)-[:Child {type:['son']}]-> (ss),

(ss)-[:Parent {type:['mother']}]->(pj),

(aj)-[:Parent {type:['father']}]->(pj),

(ss)-[:Parent {type:['mother']}]->(dj),

(aj)-[:Parent {type:['father']}]->(dj),


(mp)-[:Spouse {married:[1992]}]-> (jp),

(ap)-[:Child {type:['daughter']}]-> (jp),

(ap)-[:Child {type:['daughter']}]-> (mp),

(mp)-[:Parent {type:['mother']}]->(ap),

(jp)-[:Parent {type:['father']}]->(ap),


(aj)-[:Sibling]->(ej),

(pj)-[:Sibling]->(dj),

(ej)-[:Sibling]->(mp)
;
