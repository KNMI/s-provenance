# Running the containers without filled db

Store (with build of images):
```
docker-compose up --build -d
```

Store (without build of images):
```
docker-compose up -d
```

Viewer:
```
docker build -t viewer .
docker run -it -p9000:8080 -d viewer
```

# Restoring a database in the running mongodb
First place the zipped database in a place which is reachable by the docker container. 
Then restore it with the following command:
```
docker exec -it mongo-db mongorestore --gzip --archive=<path-to-database-zip-in-docker>
```

Then, make sure that the store container is build with the export to the correct database, for example:
```
export SPROV_DB = "verce-prov"
```

# Using swagger
Swagger URL: http://127.0.0.1:8082/swagger/

**Note:** You need to make sure that you use http instead of https when calling the API.

The api can be visualized via the following online tools:
* https://petstore.swagger.io --> Just paste the swagger url there and click explore
* https://editor.swagger.io/ --> Click 'File' > 'Import URL' and then the result will visualize to the right.
Note that there are many error messages, but if you scroll downwards you can see the actual result.

# Ansible
It is possible to pass variables to ansible playbook via the command line:
```
ansible-playbook release.yml --extra-vars '{"version":"1.23.45","other_variable":"foo"}'

```

# Points for the real README.md
* Mention that you need to have ssh access!

## Docker registry
Currently the image is hosted on dockerhub. 

### Pushing a new version of the image
TODO: Make sure that we tag the image such that it can be traced back to the github version.
First, ask rights to push to the registry. Also make sure that your image is named correctly.
This can be done via the following command:
```
docker image tag <name_of_original_image>:<tag> swagenaar/s-provenance:<tag>
```

Then use the following commands:
```
docker login (enter your docker hub userid and password)
docker push swagenaar/s-provenance:<tag>
```

## Deployment considerations
### Using NFS
In this first version of the deployment we use an NFS mount to store the MongoDB data. 
This because it will scale automatically on AWS and therefore there is no need to monitor the diskspace and increase it when limits are reached.
This will however have a performance implication, as mentioned in the MongoDB documentation:

_With the WiredTiger storage engine, 
WiredTiger objects may be stored on remote file systems if the remote file system conforms to ISO/IEC 9945-1:1996 (POSIX.1). 
Because remote file systems are often slower than local file systems, 
using a remote file system for storage may degrade performance._

_If you decide to use NFS, add the following NFS options to your /etc/fstab file: bg, nolock, and noatime._

Source: https://docs.mongodb.com/manual/administration/production-notes/#kernel-and-file-systems

Note that the specified MongoDb image indeed uses the WiredTiger storage engine.

### Loadbalancer

### AWS instance size

### Separating instances
Viewer separate from others, communication internally. Data.xml