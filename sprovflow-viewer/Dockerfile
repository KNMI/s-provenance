FROM tomcat

LABEL "TITLE"="Docker file for sprovflow-viewer"
LABEL "MAINTAINER"="prov@knmi.nl"

RUN apt-get update && apt-get install -y maven curl less vim

# compile viewer.war
COPY . /sprovflow-viewer
WORKDIR /sprovflow-viewer

RUN mvn compile war:war
		
RUN cp ./target/sprovflow-viewer.war /usr/local/tomcat/webapps

RUN cp ./j2ep-1.0.war /usr/local/tomcat/webapps


