var new_msg ={};
new_msg["payload"] = [];

for( let i = 0; i < msg["payload"]["predicted"]["mean_temperature"].length ;i++){
    new_msg["payload"].push({"measurement":"temperature", "fields": {"predicted_lower": msg["payload"]["predicted"]["lower_mean_temperature"][i]}, "tags":{"machine":"room_lab"}, "timestamp": msg["payload"]["timestamps"][i] });
    new_msg["payload"].push({"measurement":"temperature", "fields": {"predicted_upper": msg["payload"]["predicted"]["upper_mean_temperature"][i]}, "tags":{"machine":"room_lab"}, "timestamp": msg["payload"]["timestamps"][i] });
    new_msg["payload"].push({"measurement":"temperature", "fields": {"predicted_mean": msg["payload"]["predicted"]["mean_temperature"][i]}, "tags":{"machine":"room_lab"}, "timestamp": msg["payload"]["timestamps"][i] });
}

return new_msg;