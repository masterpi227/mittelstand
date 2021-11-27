cd node-red
docker build . -t node-red-local
docker run -p 1880:1880 -d node-red-local