from influxdb import InfluxDBClient
import csv
import queue
import time

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
			client = InfluxDBClient("instance-influxdb", int(8086), "user", "ax3s4cd5fv6rbgt7hnz8jmu9", "fabrikdaten")
			break
		except:
			pass
	try:
		with open('AirQualityUCI.csv','r') as csvfile:
			reader = csv.DictReader(csvfile) # csv.reader(csvfile, delimiter=',')
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
						"measurement": item_keys[key],
						"tags":{
							"machine": "room_lab"
						},
						"timestamp": int(time.time()*1000),
						"fields":{
							"value": float(dt[key])
						}
					}
					client.write_points([item], time_precision='m')
			data.put(dt)
			time.sleep(0.1)
		except:
			print("Error data processing")
	
