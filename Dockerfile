FROM tomcat:8.0.36-jre8

ARG USER=poc
ARG UID=1000
ARG GID=1000

ENV HOME="/home/poc"

RUN rm -rf /usr/local/tomcat/webapps/*

ADD target/log4shell-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

RUN addgroup --system --gid ${GID} ${USER} && \
    adduser --system --home /home/poc --uid ${UID} --gid ${GID} ${USER} && \
    chown -R ${UID}:0 /home/poc /usr/local/tomcat && \
    chmod -R g=u /home/poc /usr/local/tomcat

EXPOSE 8080

USER ${UID}

CMD ["catalina.sh", "run"]
