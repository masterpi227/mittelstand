var new_msg = {};
var value = (msg.payload.toString());

new_msg["payload"] = [{"value": value},{"log": "message"}];
return new_msg;
