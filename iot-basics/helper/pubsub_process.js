var new_msg = {};
var value = parseFloat(msg.payload.toString());
if (!isNaN(value)){
    new_msg["payload"] = [{"value": value},{"fabrik": "fabrik", "machine": "machine1", "sensor": "sensor3"}];
    return new_msg;
}