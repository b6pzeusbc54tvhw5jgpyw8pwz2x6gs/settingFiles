14.04
http://stackoverflow.com/questions/26550360/docker-ubuntu-behind-proxy
sudo service docker restart


16.04
HTTP proxy
This example overrides the default docker.service file.

If you are behind an HTTP proxy server, for example in corporate settings, you will need to add this configuration in the Docker systemd service file.

Create a systemd drop-in directory for the docker service:
$ mkdir -p /etc/systemd/system/docker.service.d
Create a file called /etc/systemd/system/docker.service.d/http-proxy.conf that adds the HTTP_PROXY environment variable:
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:80/"
If you have internal Docker registries that you need to contact without proxying you can specify them via the NO_PROXY environment variable:
Environment="HTTP_PROXY=http://proxy.example.com:80/" "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"


