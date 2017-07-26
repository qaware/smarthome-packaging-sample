FROM openjdk:8-jre-alpine

ENV DEBUG_PORT=5005 HTTPS_PORT=8443 HTTP_PORT=8080

WORKDIR /opt/esh/runtime/concierge
ADD /target/smarthome-packaging-sample-*.zip /tmp/
RUN apk add --update unzip \
 && mkdir -p /opt/esh/conf/services \
 && unzip /tmp/smarthome-packaging-sample-*.zip -d /opt/esh \
 && chmod +x /opt/esh/runtime/concierge/start.sh \
 && rm -f /tmp/smarthome-packaging-sample-*.zip \
 && apk del wget \
 && rm -rf /var/cache/apk/*
EXPOSE 5005 8080
ENTRYPOINT exec /opt/esh/runtime/concierge/start.sh debug