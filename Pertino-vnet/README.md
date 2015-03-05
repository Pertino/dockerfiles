Pertino VNet
==============

This image serves as a virtual interface into a Pertino secure network.
It instantiates a virtual interface and connects it to the account specified with Pertino credentials or 
license API key.
If you do not have a Pertino account, visit www.pertino.com to create one.

To pull, use the standard Docker image pull:
```
sudo docker pull pertino/vnet
```

This container should be run with privileged mode, however any other container can attached to it without 
requiring privileges
```
sudo docker run -t -i --privileged --hostname='pertino-test' \
  -e PERTINO_APIKEY=<your Pertino authentication API key> pertino/ubuntu
```

or
```
sudo docker run -t -i --privileged --hostname='pertino-test' \
  -e PERTINO_USERNAME=<your Pertino username> \
  -e PERTINO_PASSWORD=<your Pertino password> pertino/ubuntu
```

This application is designed to be run in conjunction with any other container that needs secure access. The companion application can use this container as the network interface effectively giving your application a secure private IP address without port mapping

To attach to the pertino network, first start your pertino/vnet container and then start your application container with the –net option. This allows you to keep the application fully secure without requiring –privileged mode. 
For example, to start a private MySQL server: 

```
docker run --net container:pertino_container_id  --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql
```

The application will only be accessible by other machines that are attached to the same network.
