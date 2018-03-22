FROM  ubuntu:17.10
ENV container docker

RUN sed -i 's/security.ubuntu.com\/ubuntu\//mirrors.aliyun.com\/ubuntu\//g' /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com\/ubuntu\//mirrors.aliyun.com\/ubuntu\//g' /etc/apt/sources.list

STOPSIGNAL 37
RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*dbus*' \
         -not -name '*ssh*' \
         -not -name '*pwr*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*docker*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;

RUN apt-get update && apt-get  -y upgrade
RUN apt-get install -y --no-install-recommends    ca-certificates  aria2 autofs  curl make squashfs-tools  xz-utils  curl bash wget axel  openssh-server dbus   iproute2   iptables   net-tools   netcat  htop iputils-ping dnsutils locate  locales  apt-transport-https git mercurial subversion procps gnupg2 dirmngr 

#python
RUN mkdir -p /root/.pip/
RUN echo [global] > ~/.pip/pip.conf
RUN echo index-url = http://mirrors.aliyun.com/pypi/simple/ >> ~/.pip/pip.conf
RUN echo [install]  >> ~/.pip/pip.conf

RUN echo trusted-host=mirrors.aliyun.com  >> ~/.pip/pip.conf

RUN curl -L https://raw.github.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
RUN apt-get update && apt-get -y dist-upgrade
ENV HOME /root
ENV PYENVPATH $HOME/.pyenv
ENV PATH $PYENVPATH/shims:$PYENVPATH/bin:$PATH
#RUN  ~/.bashrc
RUN apt-get install -y  python python-dev
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm
RUN pyenv install --list
RUN pyenv install -v    2.7.14  && pyenv install -v   3.6.3
RUN pyenv rehash
RUN pyenv global 2.7.14
RUN apt-get install -y python-pip
RUN pip install virtualenv
RUN pip install pipenv
#end python

#start desktop
# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list" \
    && curl -SL http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key | apt-key add - 
RUN  curl -SL http://ppa.launchpad.net/fcwu-tw/ppa/ubuntu/dists/zesty/Release.gpg  | apt-key add -
# add-apt-repository ppa:fcwu-tw/ppa \
RUN sh -c "echo 'deb http://ppa.launchpad.net/fcwu-tw/ppa/ubuntu zesty main ' >> /etc/apt/sources.list"
RUN sh -c "echo 'deb-src http://ppa.launchpad.net/fcwu-tw/ppa/ubuntu zesty main ' >> /etc/apt/sources.list"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 72D340A3
RUN  apt-get update 
RUN  apt-get install -y --no-install-recommends --allow-unauthenticated \
        supervisor \
        sudo vim-tiny \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        libreoffice firefox \
        fonts-wqy-microhei \
        language-pack-zh-hant language-pack-gnome-zh-hant firefox-locale-zh-hant libreoffice-l10n-zh-tw \
        nginx \
        python-pip python-dev build-essential \
        mesa-utils libgl1-mesa-dri \
        gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine pinta arc-theme \
        dbus-x11 x11-utils \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


# tini for subreap                                   
ARG TINI_VERSION=v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

ADD image/usr/lib/web/requirements.txt /tmp/
RUN pip install setuptools wheel && pip install -r /tmp/requirements.txt
ADD image /

EXPOSE 80
WORKDIR /root
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
#end desktop
ENV TERM=xterm
RUN dpkg-reconfigure locales
RUN locale-gen  zh_CN.UTF-8
ENV  LANG zh_CN.UTF-8
ENV  LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8
RUN apt-get install -y tzdata
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apt-get install -y systemd
RUN systemctl set-default multi-user.target
RUN mkdir /var/run/sshd  
RUN echo 'root:aa123456' | chpasswd
RUN sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
VOLUME ["/sys/fs/cgroup"]
ENV DEBIAN_FRONTEND="noninteractive"
#start docker
RUN apt-get update
RUN apt-get -y install apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get -y update
RUN apt-get -y install docker-ce 
#ipv 6 /etc/docker/daemon.json 
RUN echo "{" > /etc/docker/daemon.json 
RUN echo "\"ipv6\": true,"  >> /etc/docker/daemon.json 
RUN echo "\"fixed-cidr-v6\": \"2001:db8:1::/64\"  >> /etc/docker/daemon.json 
RUN echo "     }"  >> /etc/docker/daemon.json 
#end docker
#GO
RUN  apt-get -y install curl git mercurial bison make vim 
RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
env GVM_ROOT /root/.gvm
env PATH $PATH:/root/.gvm/bin
RUN  sed -i 's/go.googlesource.com\/go/github.com\/golang\/go/g' /root/.gvm/scripts/install
RUN  sed -i 's/http:\/\/golang.org\/dl\//https:\/\/storage.googleapis.com\/golang\//g' /root/.gvm/scripts/install
RUN  sed -i 's/go.googlecode.com\/files/storage.googleapis.com\/golang/g' /root/.gvm/scripts/install
RUN cat /root/.gvm/scripts/install
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && gvm install go1.4 && gvm use go1.4 && gvm install go1.8 && gvm use go1.8";
#end go
#ruby
RUN mkdir /code
RUN echo "gem: --no-ri --no-rdoc" > /code/.gemrc
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
    curl -L https://get.rvm.io | /bin/bash -s stable && \
    echo 'source /etc/profile.d/rvm.sh' >> /etc/profile && \
    /bin/bash -l -c "rvm requirements;" && \
    rvm install %ruby-version% && \
    /bin/bash -l -c "rvm use --default 2.1.0 && \
    gem install bundler"
RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org
RUN gem -v
#end ruby
#start node

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH
RUN npm config set registry http://registry.npm.taobao.org
# confirm installation
# RUN node -v
# RUN npm -v
#end node
CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]





