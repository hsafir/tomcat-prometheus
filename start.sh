JAVA_OPTS="-javaagent:/opt/jmx_prometheus_javaagent.jar=0.0.0.0:5000:/opt/config.yaml"

export CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=5000 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false" 
exec service tomcat7 start
