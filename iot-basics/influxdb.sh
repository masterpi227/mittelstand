docker run --name=tsdb -p 8086:8086 -e INFLUXDB_ADMIN_USER=user -e INFLUXDB_ADMIN_PASSWORD=ax3s4cd5fv6rbgt7hnz8jmu9 -e INFLUXDB_DB=fabrikdaten -d influxdb:1.8