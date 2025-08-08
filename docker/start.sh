#!/bin/bash

mkdir -p /var/run/dbus
chown root:messagebus /var/run/dbus
chmod 775 /var/run/dbus
dbus-daemon --system --fork

export USER=root

PASSWORD=${VNC_PASSWORD:-"password"}
PORT=${WEB_PORT:-6080}
DISPLAY=${DISPLAY:-1}
VNC_PORT=$((${DISPLAY}+5900))
RESOLUTION=${RESOLUTION:-"1080x720"}

mkdir -p /root/.vnc
echo $PASSWORD | tightvncpasswd -f > /root/.vnc/passwd && \
chmod 600 /root/.vnc/passwd

echo "vnc: 127.0.0.1:${VNC_PORT}
audio: 127.0.0.1:5711" > /etc/websockify/token.cfg 

echo ${DISPLAY}, ${RESOLUTION} ,  ${PORT} , ${VNC_PORT}

autocutsel -fork &
pulseaudio -k
pulseaudio --start
/opt/noVNC-audio-plugin/audio-proxy.sh -l 5711 &

vncserver :1 -geometry ${RESOLUTION} -depth 24 && \
websockify -D --web=/opt/noVNC --token-plugin=TokenFile --token-source=/etc/websockify/token.cfg ${PORT} && \
tail -f /dev/null
