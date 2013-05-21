t.aggregate([ { $project : { city : { $substr : ["$city",0,1] } } } , { $group : { _id : "$city", n : {$sum:1} } } ])
t.remove({ city : /[0-9].*/ }, false)

