This image is a Pertinoized version of the official 5.7 MySQL at:
https://registry.hub.docker.com/_/mysql/

This image adds three switched to the above instructions:
```
-e PERTINO_USERNAME=<Your Pertino username> 
-e PERTINO_PASSWORD=<Your Pertino password>
-e PERTINO_NETWORK=<Optionally the Pertino Network, defaults to your default Pertino Network>
```
