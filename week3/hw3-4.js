var map_closest = function map_closest() {
    var pitt = [-80.064879, 40.612044];
    var phil = [-74.978052, 40.089738];

    function distance(a, b) {
        var dx = a[0] - b[0];
        var dy = a[1] - b[1];
        return Math.sqrt(dx * dx + dy * dy);
    }

    if (distance(this.loc, pitt) < distance(this.loc, phil)) {
        emit("pitt",1);
    } else {
        emit("phil",1);
    }
}

var reduce_func = function (k,v) {
	var t=0;

	for (var i=0,l=v.length;i<l;i++) {
		t += v[i];
	}

	return t;
}

var last = { "out" : "foo_bar", "query" : { "state" : "PA" } }

db.pcat.mapReduce(map_closest, reduce_func, last);

db.foo_bar.find();

{ "_id" : "phil", "value" : 732 }
{ "_id" : "pitt", "value" : 726 }

