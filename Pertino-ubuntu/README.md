Pertino Ubuntu
==============

This is the base Docker image for Pertinoizing a container.

For now it is just a demonstration of Technology as its only real use is to login to your Pertino network and then present a shell.

To pull use the standard Docker image pull:
```
sudo docker pull pertino/ubuntu
```

To run you must run privileged:
```
export PERTINO_USERNAME=<your Pertino username>
export PERTINO_PASSWORD=<your Pertino password>
sudo docker run -t -i --privileged --hostname='pertino-test' \
  -e PERTINO_USERNAME=${PERTINO_USERNAME} \
  -e PERTINO_PASSWORD=${PERTINO_PASSWORD} pertino/ubuntu
```

The real power of this container is the ablity to embed it in other applications.  To do this you need to inherit from it inside the Dockerfile:
```
FROM pertino/ubuntu:latest
```
and call the entry code in your entrypoint shell:
```
. /pertino-entrypoint.sh
```

This should enable that application to talk over the Pertino network.  From time to time we will publish converted applications that you may use out of the box.  Until that time, feel free to experiment.
