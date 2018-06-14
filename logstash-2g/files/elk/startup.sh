#!/bin/bash
sed -i "s/Xms1g/Xms512m/g" /opt/logstash/config/jvm.options
sed -i "s/Xmx1g/Xmx512m/g" /opt/logstash/config/jvm.options

/opt/logstash/bin/logstash-plugin  install logstash-codec-netflow
/opt/logstash/bin/logstash-plugin  install logstash-filter-ruby
echo "Starting logstash"
/opt/logstash/bin/logstash -f /elk/config/logstash.conf &

