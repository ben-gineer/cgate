FROM eclipse-temurin:11-jre-alpine

LABEL maintainer="https://github.com/ben-gineer" \
      description="Clipsal C-Gate server" \
      version="3.4.0"

EXPOSE 20023 20024 20025 20026 20123

WORKDIR /usr/local/bin

#COPY rootfs/ /usr/local/bin/cgate/config
COPY src/ .

RUN set -ex && \
    unzip cgate-*.zip -d . && \
    rm cgate-*.zip && \
#    sed -i '/^jdk.tls.disabledAlgorithms=/s/TLSv1, TLSv1.1, //g' /usr/lib/jvm/java-8-openjdk/jre/lib/security/java.security && \
    ln -s /usr/local/bin/cgate/config /config && \
    ln -s /usr/local/bin/cgate/Projects /Projects && \
    ln -s /usr/local/bin/cgate/logs /logs

VOLUME ["/config", "/Projects", "/logs"]

WORKDIR /usr/local/bin/cgate
CMD ["java", "-jar", "cgate.jar"]
