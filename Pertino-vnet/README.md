Pertino VNet
==============

This image serves as a virtual interface into a Pertino secure network.
It instantiated a virtual interface and connects it to the account specified with Pertino credentials or 
license API key.

To pull use the standard Docker image pull:
```
sudo docker pull pertino/vnic
```

To run you must run privileged:
```
export PERTINO_USERNAME=<your Pertino username>
export PERTINO_PASSWORD=<your Pertino password>
sudo docker run -t -i --privileged --hostname='pertino-test' \
  -e PERTINO_USERNAME=${PERTINO_USERNAME} \
  -e PERTINO_PASSWORD=${PERTINO_PASSWORD} pertino/ubuntu
```

or
```
export PERTINO_APIKEY=<your Pertino machine authentication API key>
sudo docker run -t -i --privileged --hostname='pertino-test' \
  -e PERTINO_APIKEY=${PERTINO_APIKEY} pertino/ubuntu
```


This application is designed to be run in conjunction with any other container that needs secure access.
The companion aplication can use this continer as the network interface effectivly giving your
application a sucure private IP address without port mapping

To attach to the pertino network, first start your pertino//vnet container and then start your application container with the --net option.  This allows you to keep the application fully secure without requiring --privileged mode.
For example, to start a private myswl server:
```
docker run --net container:pertino_container_id  --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql
```

The application will only be accessable by other machines that are attached to the same network.

