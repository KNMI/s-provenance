# image knmi
FROM ubuntu

LABEL description="KNMI PROVENANCE STORE CONTAINER"

ENV SPROV_DB=sprov-db
ENV SPROV_DB=verce-prov


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


# couple this file to a seperate mongo instance, pull docker mongo 3.4
# see docker-compose.yml

# python requirements
COPY requirements.txt /prov/
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8082

# Copy the provenance-api code.
WORKDIR /provenance-api/src/prov-services/
COPY . /provenance-api/

# added mongo features...
# docker0 bridge network used for dual container case
# RUN curl 172.17.0.1:27017 # mongodb access via docker bridge.

RUN echo 'export RAAS_LOGGING="True"' >> docker_entry.sh
RUN echo 'export RAAS_REPO="mongodb://172.17.0.1/$SPROV_DB" ' >> docker_entry.sh

RUN echo 'gunicorn -w 9 -b 0.0.0.0:8082 "flask_raas:bootstrap_app()" --log-level debug --backlog 0 --timeout 120 --error-logfile error.log --log-file access.log' >> docker_entry.sh 


RUN echo 'mongo 172.17.0.1:27017/$SPROV_DB /provenance-api/resources/ensure_indexes.js' >>  mongo_js.sh
RUN echo 'mongo 172.17.0.1:27017/$SPROV_DB /provenance-api/resources/lineage_map_reduce.js' >>  mongo_js.sh

ENTRYPOINT bash docker_entry.sh 

CMD bash mongo_js.sh

