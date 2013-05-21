t.aggregate({$group:{_id:{state:"$state"},nzip:{$sum:1}}},{$sort:{nzip:-1}})

