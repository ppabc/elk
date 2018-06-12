#!/bin/bash
echo "Starting elasticsearch"
/opt/elasticsearch/bin/elasticsearch &
sleep 10
echo "Starting logstash"
/opt/logstash/bin/logstash -f /opt/config/conf.d/logstash.conf &
sleep 10
echo "Starting kibana"
/opt/kibana/bin/kibana
