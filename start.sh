#!/usr/bin/env bash

ES_HEAP_SIZE=512m /opt/elasticsearch/bin/elasticsearch -d > /dev/null 2>&1
/opt/logstash/bin/logstash agent -f /vagrant/logstash.conf > /dev/null 2>&1 &

echo "Marvel is running at http://localhost:9200/_plugin/marvel/"
echo "Kibana is running at http://localhost:8080/index.html#/dashboard/file/logstash.json"
