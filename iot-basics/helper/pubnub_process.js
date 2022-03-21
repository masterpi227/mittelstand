var new_msg = {};
new_msg["payload"] = [{"value": parseFloat(msg["payload"]["ambient_temperature"])},{"fabrik": "fabrik", "machine": "machine4", "sensor": "ambient_temperature"}];
var new_msg2 = {};
new_msg2["payload"] = [{"value": parseFloat(msg["payload"]["photosensor"])},{"fabrik": "fabrik", "machine": "machine4", "sensor": "photosensor"}];
var new_msg3 = {};
new_msg3["payload"] = [{"value": parseFloat(msg["payload"]["radiation_level"])},{"fabrik": "fabrik", "machine": "machine4", "sensor": "radiation_level"}];
var new_msg4 = {};
new_msg4["payload"] = [{"value": parseFloat(msg["payload"]["humidity"])},{"fabrik": "fabrik", "machine": "machine4", "sensor": "humidity"}];


return [new_msg, new_msg2, new_msg3, new_msg4]