FROM nodered/node-red

RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production

COPY settings.js /data/settings.js
COPY uci-secom.csv /data/data.csv

WORKDIR /usr/src/node-red
RUN npm install node-red-contrib-influxdb
RUN npm install node-red-contrib-google-cloud
RUN npm install node-red-contrib-pubnub
RUN npm install node-red-contrib-ttn
RUN npm install node-red-contrib-opcua
