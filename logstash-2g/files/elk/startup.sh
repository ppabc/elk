#!/bin/bash
sed -i "s/Xms1g/Xms512m/g" /opt/logstash/config/jvm.options
sed -i "s/Xmx1g/Xmx512m/g" /opt/logstash/config/jvm.options

echo "Starting logstash"
/opt/logstash/bin/logstash -f /elk/config/logstash.conf &

