FROM aqzt/docker-alpine:oraclejdk8

# adding elk username because elasticsearch can not run as root anymore
RUN set -x ; \
    addgroup -g 1000 elk ; \
    adduser -G elk elk -D -h /opt

# set env variables
ENV ELK_VERSION  5.6.9
ENV ELASTIC_URL  https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELK_VERSION.tar.gz
ENV LOGSTASH_URL https://artifacts.elastic.co/downloads/logstash/logstash-$ELK_VERSION.tar.gz
ENV KIBANA_URL   https://artifacts.elastic.co/downloads/kibana/kibana-$ELK_VERSION-linux-x86_64.tar.gz

RUN apk update \
    && apk upgrade \
    && apk add nano curl bash sudo tzdata openssl libstdc++ \
    && cp -R /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && echo 'Asia/Shanghai' > /etc/timezone  \
    && echo '%elk ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && sed -i 's/dev\/random/dev\/urandom/g' /usr/lib/jvm/jre/jre/lib/security/java.security

USER elk
WORKDIR /opt

RUN curl -o /tmp/elastic.tgz $ELASTIC_URL \
    && tar -xzf /tmp/elastic.tgz -C /opt \
    && curl -o /tmp/logstash.tgz $LOGSTASH_URL \
    && tar -xzf /tmp/logstash.tgz -C /opt \
    && curl -o /tmp/kibana.tgz $KIBANA_URL \
    && tar -xzf /tmp/kibana.tgz -C /opt \
    && ln -s kibana-* kibana \
    && ln -s logstash-* logstash \
    && ln -s elasticsearch-* elasticsearch \
    && echo 'network.host: 0.0.0.0' >>  /opt/elasticsearch/config/elasticsearch.yml \
    && echo 'server.host: "0.0.0.0"' >> /opt/kibana/config/kibana.yml \
    && rm -rf /tmp/*.tgz
RUN mkdir -p /opt/ssl /opt/logstash/config/conf.d 

ADD files /

EXPOSE 9200 9300 5601 5044

ENTRYPOINT "/elk/startup.sh"
