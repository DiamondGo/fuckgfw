# Run Chrome in a container
#
# docker run -it \
#	--net host \ # may as well YOLO
#	--cpuset-cpus 0 \ # control the cpu
#	--memory 512mb \ # max memory it can use
#	-v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#	-e DISPLAY=unix$DISPLAY \
#	-v $HOME/Downloads:/home/chrome/Downloads \
#	-v $HOME/.config/google-chrome/:/data \ # if you want to save state
#	--security-opt seccomp=$HOME/chrome.json \
#	--device /dev/snd \ # so we have sound
#	-v /dev/shm:/dev/shm \
#	--name chrome \
#	jess/chrome
#
# You will want the custom seccomp profile:
# 	wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json

# Base docker image
FROM ubuntu:16.04
# LABEL maintainer "Kenneth Tse <fuckgfw@linux.com>"
RUN apt-get update -y
RUN apt-get install python3-pip -y
RUN pip3 install shadowsocks

RUN apt-get install wget -y
RUN wget https://github.com/xtaci/kcptun/releases -O - 2>/dev/null | grep kcptun-linux-amd64- | grep "a href" | sort | tail -1 | awk -F '"' '{print $2}' | { read uri; wget "https://github.com${uri}" -O /tmp/kcptun.tar.gz -c -t 0; }
RUN mkdir /usr/local/kcptun -p
RUN tar xzvf /tmp/kcptun.tar.gz -C /usr/local/kcptun
RUN chown 0:0 /usr/local/kcptun/*




#   # add script
#   RUN touch /usr/local/bin/fuckgfw_client.sh
#   
#   RUN echo "#!/bin/bash" >> /usr/local/bin/fuckgfw_client.sh
#   RUN echo "if [ \$# -ne 3 ]; then" >> /usr/local/bin/fuckgfw_client.sh
#   RUN echo "    echo usage: \$0 remote_kcptun local_socks_port password" >> /usr/local/bin/fuckgfw_client.sh
#   RUN echo "    exit" >> /usr/local/bin/fuckgfw_client.sh
#   RUN echo "fi" >> /usr/local/bin/fuckgfw_client.sh
#   RUN echo "nohup /usr/local/bin/client_linux_amd64 -r \$1 -l :9527 -mode fast2 > /tmp/kcp.log 2>&1 &" >> /usr/local/bin/fuckgfw_client.sh
#   RUN echo "sleep 3" >> /usr/local/bin/fuckgfw_client.sh
#   RUN echo "nohup /usr/local/bin/sslocal -s 127.0.0.1 -p 9527 -l \$2 -m aes-256-cfb -k \$3 --pid-file /tmp/ss.pid > /tmp/ss.log 2>&1 &" >> /usr/local/bin/fuckgfw_client.sh
#   
#   
#   RUN chmod +x /usr/local/bin/fuckgfw_client.sh
#   
#   RUN apt-get purge --auto-remove -y wget
#   RUN rm -rf /tmp/kcp*



# ADD https://github.com/xtaci/kcptun/releases/download/v20170525/kcptun-linux-amd64-20170525.tar.gz /tmp/kcptun-linux-amd64-20170525.tar.gz

# ADD https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb /src/google-talkplugin_current_amd64.deb
# 
# # Install Chrome
# RUN apt-get update && apt-get install -y \
# 	apt-transport-https \
# 	ca-certificates \
# 	curl \
# 	gnupg \
# 	hicolor-icon-theme \
# 	libgl1-mesa-dri \
# 	libgl1-mesa-glx \
# 	libpango1.0-0 \
# 	libpulse0 \
# 	libv4l-0 \
# 	fonts-symbola \
# 	--no-install-recommends \
# 	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
# 	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
# 	&& apt-get update && apt-get install -y \
# 	google-chrome-stable \
# 	--no-install-recommends \
# 	&& dpkg -i '/src/google-talkplugin_current_amd64.deb' \
# 	&& apt-get purge --auto-remove -y curl \
# 	&& rm -rf /var/lib/apt/lists/* \
# 	&& rm -rf /src/*.deb
# 
# # Add chrome user
# RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
#     && mkdir -p /home/chrome/Downloads && chown -R chrome:chrome /home/chrome
# 
# COPY local.conf /etc/fonts/local.conf
# 
# # Run Chrome as non privileged user
# USER chrome
# 
# # Autorun chrome
# ENTRYPOINT [ "google-chrome" ]
# CMD [ "--user-data-dir=/data" ]

