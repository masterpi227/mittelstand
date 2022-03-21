import paho.mqtt.client as mqtt
import csv
import queue
import time
import json

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))

if __name__ == "__main__":

	data = queue.Queue()

	item_keys = {
		"CO(GT)": "carbon_monoxide",
		"PT08.S1(CO)": "carbon_monoxide_tin",
		"NMHC(GT)": "non_metanic_hydrocarbone",
		"C6H6(GT)": "benzene",
		"PT08.S2(NMHC)": "non_metanic_hydrocarbone_titania",
		"NOx(GT)": "nox_stickoxidde",
		"PT08.S3(NOx)": "nox_stickoxidde_tungsten",
		"NO2(GT)": "nitrogen_dioxide",
		"PT08.S4(NO2)": "nitrogen_dioxide_tungsten",
		"PT08.S5(O3)": "ozone_indium",
		"T": "temperature",
		"RH": "relative_humidity",
		"AH": "absolute_humidity"
	}


	while True:
		try:
			
			client = mqtt.Client()
			client.on_connect = on_connect
			client.on_message = on_message

			client.connect("instance-mosquitto", 1883, 1800)
			break
		except:
			pass
	try:
		with open('AirQualityUCI.csv','r') as csvfile:
			reader = csv.DictReader(csvfile, delimiter=";", quotechar="'") # csv.reader(csvfile, delimiter=',')
			for row in reader:
				data.put(row)
	except:
		print("Error loading csv")

	while not data.empty():
		try:
			dt = data.get()
			for key in dt.keys():
				if key in item_keys:
					item = {
						"measurement": item_keys[key].strip(),
						"machine": "room_lab",
						"timestamp": int(time.time()*1000),
						"value": float(dt[key].replace(',','.'))
					}
					client.publish("room_lab/state/"+item_keys[key].strip(), json.dumps(item), 2)		
				else:
					pass #print(key)
			data.put(dt)
			time.sleep(0.1)
		except:
			print("Error data processing")