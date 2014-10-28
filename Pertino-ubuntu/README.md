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
sudo docker run -d --name mypertino --privileged --hostname='pertino-test' \
  -e PERTINO_USERNAME=${PERTINO_USERNAME} \
  -e PERTINO_PASSWORD=${PERTINO_PASSWORD} pertino/ubuntu
```

The real power of this container is the ablity to use this as the networking for another container
```
docker run -it --rm --net container:mypertino debian:jessie bash
```

This should enable that application to talk over the Pertino network.
