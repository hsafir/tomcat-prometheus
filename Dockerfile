FROM ubuntu:16.04
USER root
RUN apt-get -y update

RUN apt-get -y install wget

RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update

# Accept the license
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections

RUN apt-get -y install oracle-java8-installer

RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/default/tomcat7

ADD apache-tomcat-8.5.23.tar.gz /opt

RUN ls /opt/apache-tomcat-8.5.23
RUN chmod -R 777 /opt/apache-tomcat-8.5.23
ADD catalina.sh /opt/apache-tomcat-8.5.23/bin/
ADD server.xml /opt/apache-tomcat-8.5.23/conf/
ADD onlinebanking.war /opt/apache-tomcat-8.5.23/webapps/
RUN chmod -R 777 /opt/apache-tomcat-8.5.23/webapps/.
ADD jmx_prometheus_javaagent.jar /opt
ADD config.yaml /opt
ENV CATALINA_HOME /opt/apache-tomcat-8.5.23
ENV PATH $CATALINA_HOME/bin:$PATH
RUN chmod +x ${CATALINA_HOME}/bin/*.sh
WORKDIR $CATALINA_HOME
#USER default
EXPOSE 8084 5004

CMD ["catalina.sh","run"]
