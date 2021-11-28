var msg1 = {};
msg1["payload"] = msg["payload"]["col2"];
msg1["topic"] = "fabrik/machine1/sensor1";
var msg2 = {};
msg2["payload"] = msg["payload"]["col3"];
msg2["topic"] = "fabrik/machine2/sensor1";
var msg3 = {};
msg3["payload"] = msg["payload"]["col4"];
msg3["topic"] = "fabrik/machine3/sensor1";

var msg4 = {};
msg4["payload"] = msg["payload"]["col6"];
msg4["topic"] = "fabrik/machine1/sensor2";
var msg5 = {};
msg5["payload"] = msg["payload"]["col10"];
msg5["topic"] = "fabrik/machine2/sensor2";
var msg6 = {};
msg6["payload"] = msg["payload"]["col13"];
msg6["topic"] = "fabrik/machine3/sensor2";

var msg7 = {};
msg7["payload"] = msg["payload"]["col9"];
msg7["topic"] = "fabrik/machine1/sensor3";
var msg8 = {};
msg8["payload"] = msg["payload"]["col11"];
msg8["topic"] = "fabrik/machine2/sensor3";
var msg9 = {};
msg9["payload"] = msg["payload"]["col12"];
msg9["topic"] = "fabrik/machine3/sensor3";

return [msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9];