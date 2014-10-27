Pertino Ubuntu
==============

This is the base Docker image for Pertinoizing a container.

For now it is just a demonstration of Technology as it's only real use is to login and present a shell.

To pull use the standard Docker image pull:
```
sudo docker pull pertino/ubuntu
```

To run it is slightly different in that you must run priviledged:
```
export PERTINO_USERNAME=<your Pertino username>
export PERTINO_PASSWORD=<your Pertino password>
sudo docker run -t -i --privileged --hostname='pertino-test' \
  -e PERTINO_USERNAME=${PERTINO_USERNAME} \
  -e PERTINO_PASSWORD=${PERTINO_PASSWORD} pertino/ubuntu
```

All this will do is drop you into a shell inside the container and have you connected to your Pertino network.


The real power of this container is the ablity to embedded it in other applications.  To do so you need to inherit from it in the Dockerfile:
```
FROM pertino/ubuntu:latest
```
and call the entry code in your entrypoint shell:
```
/pertino-entrypoint.sh
```

This should enable that application to talk over the Pertino network.  We will publish from time to time converted applications that you may use out of the box.  Until that time feel free to experiment.
