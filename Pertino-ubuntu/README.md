Pertino Ubuntu
==============

This is the base Docker image for Pertinoizing a container.

For now it is just a demonstration of Technology.

To use build using the standard Docker image building:
```
sudo docker build -t pertino-ubuntu .
```

To run it is slightly different in that you must run priviledged:
```
export PERTINO_USERNAME=<your Pertino username>
export PERTINO_PASSWORD=<your Pertino password>
sudo docker run -t -i --privileged --hostname='pertino-test' -e PERTINO_USERNAME=${PERTINO_USERNAME} -e PERTINO_PASSWORD=${PERTINO_PASSWORD} pertino-ubuntu
```

