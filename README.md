on server linux:
docker run -d -p 9528:9528/udp --name fuckgfw --rm flowerseems/fuckgfw /usr/local/bin/fuckgfw_server.sh your.password 9528

Here we use 9528 as udp listen port(default for client also).

on clinet linux:
docker run -d -p 1080:1080 --name fuckgfw --rm -e REMOTE_SERVER=your.vps.ip -e SS_PASSWORD=your.password flowerseems/fuckgfw
