db.policies.find( { status : { $ne : "expired" }, coverages : { $elemMatch : { type : "liability", rates : { $elemMatch : { rate : { $gte : 100 }, current : true } } } } } )

