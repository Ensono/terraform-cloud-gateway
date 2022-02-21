FROM amazoncorretto:11-al2-jdk

RUN yum install aws-cli -y

# COPY ./utils/ /cgateway/

CMD [ "bash", "/cgateway/bootstrap.sh" ]
