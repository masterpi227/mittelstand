var new_msg = {};
new_msg["payload"] = [];
//new_msg["precision"] = "ms";

msg["payload"]["data"].forEach(function(item){
    //var datum = new Date(item["end_timestamp"]);
    // datum.toISOString()
    new_msg["payload"].push({"measurement":"marktdaten", "fields":{"value": item["marketprice"]}, "tags": {"type":"strom"}, "timestamp": item["end_timestamp"]});
});

//for(var data in msg["payload"]["data"]){
//    new_msg["payload"].push({"measurement":"marktdaten", "fields":{"value": data["marketprice"]}, "tags": {"type":"strom"}, "timestamp": data["end_timestamp"]})
//}
return new_msg;