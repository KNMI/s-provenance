# image knmi
FROM ubuntu

LABEL description="KNMI PROVENANCE STORE CONTAINER"

RUN mkdir -p /prov/
WORKDIR /prov/

# linux tools
RUN apt-get update && apt-get install -y \
  curl  \
  unzip \
  procps \
  python \
  python-pip \
  vim

# mongodb-org v3.4 required, mongo shell is necessary to pass js instructions by services.
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update && apt-get install -y mongodb-org

# python requirements
COPY requirements.txt /prov/
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8082

# Copy the provenance-api code.
COPY ./src /provenance-api/src
COPY ./resources /provenance-api/resources

WORKDIR /provenance-api/src/prov-services/
COPY ./docker_entry.sh .


# couple this file to a seperate mongo instance, pull docker mongo 3.4
# see docker-compose.yml
# Default value for the mongo db, can be overridded by passing a different value when starting the container
ENV SPROV_DB=sprov-db
ENV SPROV_DB_HOST=172.17.0.1
ENV SPROV_DB_PORT=27017

ENTRYPOINT bash docker_entry.sh
