docker run -p 8077:8077 -v $PWD/loudml/lib:/var/lib/loudml:rw -v $PWD/loudml/config.yml:/etc/loudml/config.yml:ro -v $PWD/ludml/model.json:/etc/loudml/model.json:ro -d loudml/loudml