FROM haiwangio/desktop
RUN	apt-get update
RUN apt-get install -y x11vnc nginx 
ADD asset /
ADD asset/usr/lib/web/requirements.txt /tmp/
RUN apt-get install -y  python-pip python-dev build-essential
#RUN pip install setuptools wheel && pip install -r /tmp/requirements.txt
RUN apt-get install -y dbus-x11 x11-utils
RUN systemctl enable x11vnc.service 
RUN systemctl enable noVNC.service
RUN apt-get install -y xvfb
RUN systemctl enable webVNC.service
RUN systemctl enable xvfb.service 
RUN systemctl enable openbox.service
RUN systemctl enable pcmanfm.service
RUN systemctl enable lxpanel.service

