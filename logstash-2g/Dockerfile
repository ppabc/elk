FROM aqzt/docker-alpine:oraclejdk8

# adding elk username because elasticsearch can not run as root anymore
RUN addgroup -g 1000 elk
RUN adduser -G elk elk -D -h /opt

# set env variables
ENV ELK_VERSION  5.6.9
ENV LOGSTASH_URL https://artifacts.elastic.co/downloads/logstash/logstash-$ELK_VERSION.tar.gz

RUN apk update \
    && apk upgrade \
    && apk add nano curl bash sudo openssl libstdc++ \
    && echo '%elk ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && sed -i 's/dev\/random/dev\/urandom/g' /usr/lib/jvm/jre/jre/lib/security/java.security

USER elk
WORKDIR /opt

RUN curl -o /tmp/logstash.tgz $LOGSTASH_URL \
    && tar -xzf /tmp/logstash.tgz -C /opt \
    && ln -s logstash-* logstash \
    && /opt/logstash/bin/logstash-plugin  install logstash-codec-netflow \
    && /opt/logstash/bin/logstash-plugin  install logstash-filter-ruby \
    && rm -rf /tmp/*.tgz
RUN mkdir -p /opt/ssl /opt/logstash/config/conf.d 

ADD files /

EXPOSE 9200 9300 5601 5044

ENTRYPOINT "/elk/startup.sh"
