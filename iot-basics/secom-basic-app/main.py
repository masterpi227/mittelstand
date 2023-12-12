import paho.mqtt.client as mqtt
import csv
import queue
import time
import json
import sys
import os

def on_connect(client, userdata, flags, rc):
	print("Connected with result code "+str(rc))

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
		"NOx(GT)": "nox_stickoxide",
		"PT08.S3(NOx)": "nox_stickoxide_tungsten",
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
			client.loop_start()
			break
		except:
			print("Error in mqtt connection")
	try:
		with open('uci-secom.csv','r') as csvfile:
			reader = csv.DictReader(csvfile, delimiter=",", quotechar="'") # csv.reader(csvfile, delimiter=',')
			for row in reader:
				data.put(row)
	except:
		print("Error loading csv")

	while not data.empty():
		try:
			dt = data.get()
			#print(dt)
			for key,value in dt.items():
				#if key in item_keys:
				if str(key) != "Time":
					try:
						item = {
								"measurement": "sensor",
								"machine": ("station"+str(key.replace("/","").strip()) if str(key).find('Pass') == -1 else str(key).replace("/","").strip()),
								"timestamp": int(time.time()*1000),
								"value": float(value.replace(',','.'))
						}
						client.publish(topic="prodline/state/"+item['machine'], payload=json.dumps(item))
					except:
						pass
				#else:
				#       pass
						#print(key)
				time.sleep(1)
			data.put(dt)
			
		except:
			print("Error data processing")