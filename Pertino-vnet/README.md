#Pertino Overview

Pertino delivers networking as a service and enables any size business to build and manage a cloud networks.

These cloud networks overlay the public Internet, securely connecting devices, servers, vms or containers across offices. data centers and public clouds. 
Customers can link workloads running in the data centers with public cloud(s) and make them seem like they are part of a contiguous LAN space.
All the underlying IP, DNS and NAT management is delivered transparently with no hardware or no configuration.  
Since Pertino relies on just an outbound 443 connection to establish a network, no changes to firewall settings or security groups are needed to make it work.  

All inbound ports on your corporate firewall or external access to cloud instances can be blocked and Pertino could be used as a secure overlay.

Pertino tunnels are secured with a best-in-class PKI infrastructure and AES 256-bit SSL encryption.  Pertino can be used for the following use-cases:
- Link servers in data center with VMs/containers in the cloud
- Link containers on multiple machines exclusively over a secure Pertino-based connection to setup a HA pair for instance

##How to use Pertino VNet

This image serves as a virtual interface into a Pertino secure network. It instantiates a virtual interface and connects it to the account specified with Pertino credentials or network API key. 

Here are instructions on getting a network API key - <LINK>

To pull, use the standard Docker image pull:
```
sudo docker pull pertino/vnet
```
This container should be run with privileged mode, however any other container can attached to it without requiring privileges
```
sudo docker run -t -i --privileged \
  -e PERTINO_APIKEY=<your Pertino API key> pertino/vnet
```
Or using your account credentials directly
```
sudo docker run -t -i --privileged \
  -e PERTINO_USERNAME=<your Pertino username> \
  -e PERTINO_PASSWORD=<your Pertino password> pertino/vnet
```
This application is designed to be run in conjunction with any other container that needs secure access. The companion application can use this container as the network interface effectively giving your application a secure private IP address without port mapping

To attach to the pertino network, first start your pertino/vnet container and then start your application container with the –net option. This allows you to keep the application fully secure without requiring –privileged mode. For example, to start a private MySQL server:
```
docker run --net container:pertino_container_id  --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql
```
The application will only be accessible by other machines that are attached to the same network.

The above approach can be used to address two scenarios:

- Multiple containers on a host use a single pertino network interface (Many -1) and are all linked to a single virtual network.
- Each container on a host has a dedicated  pertino network interface (1-1).  This way each container gets a unique virtual IP and can be linked to potentially a different pertino virtual network from its peer containers on the host.

##Supported Docker Versions

This image is officially supported on Docker version 1.5.0.
Support for older versions (down to 1.0) is provided on a best-effort basis.

 
 
##User Feedback

If you have any problems with or questions about this image, please contact us at https://support.pertino.com/


