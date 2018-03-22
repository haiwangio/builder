FROM haiwangio/systemd
RUN apt-get update  ; \
	 apt-get install -y iptables ca-certificates lxc lxde
RUN apt-get update ; apt-get install -y  xrdp language-pack-zh-hant language-pack-zh-hans  && apt-get clean; 

#RUN apt-get update && apt-get install --no-install-recommends  -y lubuntu-desktop 
#RUN apt-get update && apt-get install --no-install-recommends -y xrdp
VOLUME ["/sys/fs/cgroup"]
#RUN apt-get install -y lubuntu-desktop xrdp
RUN     echo 'root:root@root' |chpasswd
RUN	useradd -ms /bin/bash user && \
	echo 'user:password' |chpasswd
EXPOSE 3389
#ENTRYPOINT /etc/init.d/xrdp start && tail -F /var/log/xrdp-sesman.log
