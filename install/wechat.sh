apt install libatomic1 libxkbcommon-x11-0 libnss3 -y
apt install libxcb* -y

wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb
dpkg -i WeChatLinux_x86_64.deb 

mkdir -p /root/.xwechat/crashinfo