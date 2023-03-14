var new_msg = {};
new_msg["measurement"] = msg.payload["measurement"];
var tags = msg.topic.split("/");
new_msg.payload = [{ "value": msg.payload["value"] }, { "machine": tags[0], "sensor": tags[2] }];
return new_msg;

/*
var tags = msg.topic.split("/");
var value = parseFloat(msg.payload);
if (!isNaN(value)) {
    var new_msg = {};
    new_msg["payload"] = [{ "value": value }, { "fabrik": tags[0], "machine": tags[1], "sensor": tags[2] }];
    return new_msg
}
*/