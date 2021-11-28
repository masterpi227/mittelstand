var tags = msg.topic.split("/");
var value = parseInt(msg.payload);
if (!isNaN(value)){
    var new_msg = {};
    new_msg["payload"] = [{"value": value},{"fabrik": tags[0], "machine": tasg[1], "sensor": tags[2]}];
    return new_msg
}