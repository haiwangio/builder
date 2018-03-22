FROM haiwangio/desktop
#python
RUN mkdir -p /root/.pip/
RUN echo [global] > ~/.pip/pip.conf
RUN echo index-url = http://mirrors.aliyun.com/pypi/simple/ >> ~/.pip/pip.conf
RUN echo [install]  >> ~/.pip/pip.conf

RUN echo trusted-host=mirrors.aliyun.com  >> ~/.pip/pip.conf
RUN apt-get update && apt-get -y dist-upgrade

RUN apt-get install -y  python python-dev
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm curl
RUN curl -L https://raw.github.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
ENV HOME /root
ENV PYENVPATH $HOME/.pyenv
ENV PATH $PYENVPATH/shims:$PYENVPATH/bin:$PATH
#RUN  ~/.bashrc
RUN pyenv install --list
RUN pyenv install -v    2.7.14  && pyenv install -v   3.6.3
RUN pyenv rehash
RUN pyenv global 2.7.14
RUN apt-get install -y python-pip
RUN pip install virtualenv
RUN pip install pipenv
#end python
#start docker
RUN apt-get update
RUN apt-get -y install apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -
#RUN add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
RUN add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu  artful stable"
RUN apt-get -y update
RUN apt-get -y install docker-ce 
#ipv 6 /etc/docker/daemon.json 
RUN mkdir /etc/docker
RUN echo "{" > /etc/docker/daemon.json 
RUN echo "\"ipv6\": true,"  >> /etc/docker/daemon.json 
RUN echo "\"fixed-cidr-v6\": \"2001:db8:1::/64\""  >> /etc/docker/daemon.json 
RUN echo "     }"  >> /etc/docker/daemon.json 
#end docker
#GO
#RUN  apt-get -y install curl git mercurial bison make vim 
RUN apt-get install -y  curl git mercurial make binutils bison gcc build-essential
RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
env GVM_ROOT /root/.gvm
env PATH $PATH:/root/.gvm/bin
RUN  sed -i 's/go.googlesource.com\/go/github.com\/golang\/go/g' /root/.gvm/scripts/install
RUN  sed -i 's/http:\/\/golang.org\/dl\//https:\/\/studygolang.com\/dl\/golang\//g' /root/.gvm/scripts/install
RUN  sed -i 's/go.googlecode.com\/files/studygolang.com\/dl\/golang\//g' /root/.gvm/scripts/install
RUN cat /root/.gvm/scripts/install
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && gvm install go1.4 -B  && gvm use go1.4 "
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && gvm install go1.9.3   -B  && gvm use go1.9.3 "
#end go
#ruby
RUN mkdir /code
RUN echo "gem: --no-ri --no-rdoc" > /code/.gemrc
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
    curl -L https://get.rvm.io | /bin/bash -s stable && \
    echo 'source /etc/profile.d/rvm.sh' >> /etc/profile 
RUN    /bin/bash -l -c " rvm requirements;" 
RUN  /bin/bash -l -c "   rvm install 2.5.0 ; "
RUN     /bin/bash -l -c " rvm use --default 2.5.0 && \
    gem install bundler "
RUN /bin/bash -l -c " gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org "
RUN /bin/bash -l -c " gem -v "
#end ruby
#start node

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
RUN /bin/bash -l -c " source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default $NODE_VERSION"
#RUN /bin/bash -l -c " source $NVM_DIR/nvm.sh && nvm install stable     "
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH
#RUN  npm config set registry http://registry.npm.taobao.org 
# confirm installation
#RUN nvm  install node
RUN /bin/bash -l -c  "source $NVM_DIR/nvm.sh && node -v "
RUN /bin/bash -l -c "source $NVM_DIR/nvm.sh && npm -v "
#RUN   echo 'source /root/.gvm/scripts/gvm' >> /etc/profile
RUN   echo 'source $NVM_DIR/nvm.sh' >> /etc/profile
#RUN  echo 'export PATH = ${PYENVPATH}/shims:${PYENVPATH}/bin:$PATH' >> /etc/profile
RUN mkdir -p /profile
RUN cp /root/.gvm/scripts/gvm  /profile/gvm
RUN cp $NVM_DIR/nvm.sh /profile/nvm.sh
RUN cp  /etc/profile.d/rvm.sh /profile/rvm.sh
#end node
RUN echo 'root:'ddd123 | chpasswd

