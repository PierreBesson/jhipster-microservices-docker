FROM anapsix/alpine-java

ADD target/*.war app.war

RUN bash -c 'touch /app.war'
EXPOSE 8080
VOLUME /tmp
CMD java -jar -Deureka.client.serviceUrl.defaultZone=http://registry:8761/eureka/ -Dspring.cloud.config.uri=http://registry:8761/config app.war
