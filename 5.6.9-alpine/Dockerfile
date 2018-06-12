FROM logstash:5.6.9-alpine

ENV PLUGIN_BIN "/usr/share/logstash/bin/logstash-plugin"

RUN "$PLUGIN_BIN" install logstash-input-beats
RUN "$PLUGIN_BIN" install logstash-input-syslog
RUN "$PLUGIN_BIN" install logstash-filter-date
RUN "$PLUGIN_BIN" install logstash-filter-grok
RUN "$PLUGIN_BIN" install logstash-filter-urldecode
RUN "$PLUGIN_BIN" install logstash-filter-useragent
RUN "$PLUGIN_BIN" install logstash-filter-geoip
RUN "$PLUGIN_BIN" install logstash-output-elasticsearch

COPY ./conf /etc/logstash

CMD ["-f", "/etc/logstash/logstash.conf"]
