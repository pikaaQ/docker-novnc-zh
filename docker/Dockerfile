FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
 
# 安装本地化支持包（根据需要安装）
RUN apt-get update && apt-get install -y locales && \
    locale-gen zh_CN.UTF-8 && \
    update-locale LANG=zh_CN.UTF-8

# 安装基础软件
RUN apt-get update && apt-get install -y \
    iputils-ping \
    dnsutils \
    net-tools \
    python3 \
    python3-numpy \
    lsb-release \
    vim \
    unzip \
    wget \
    curl \
    git \
    tzdata \
    software-properties-common \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 设置环境变量，指定语言为中文
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh:en
ENV LC_ALL zh_CN.UTF-8
RUN ln -sf /usr/share/zoneinfo/Asia/Shangehai /etc/localtime

# 安装桌面和vnc
RUN apt-get update && apt-get install -y \
    xorg \
    dbus \
    dbus-x11 \
    xfce4 \
    xfce4-session \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    autocutsel \
    websockify \
    xfce4-terminal \
    mousepad \
    tightvncpasswd \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 安装novnc
RUN git clone --depth 1 https://github.com/novnc/noVNC.git /opt/noVNC
#COPY noVNC /opt/noVNC

# 安装中文输入法
RUN apt-get update && apt-get install -y \
    fonts-wqy-microhei \
    fonts-wqy-zenhei \
    fonts-noto-cjk \
    ttf-mscorefonts-installer \
    adwaita-icon-theme-full \
    humanity-icon-theme \
    fonts-noto-cjk \
    fcitx \
    fcitx-config-gtk \
    fcitx-frontend-gtk2 \
    fcitx-m17n \
    fcitx-module-x11 \ 
    fcitx-ui-classic \
    fcitx-tools \ 
    fcitx-googlepinyin \
    im-config \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 安装chrome, chrome和输入法有冲突，放弃
#COPY google-chrome-stable_current_amd64.deb /google-chrome-stable_current_amd64.deb
#RUN apt-get update && apt-get install -y /google-chrome-stable_current_amd64.deb && \
#    rm /google-chrome-stable_current_amd64.deb

# 安装firefox(非snap版)
RUN apt-get update && apt-get install -y \
    gpg \
    gnupg2 \
    --no-install-recommends && \
    apt-get clean && \                                                          
    rm -rf /var/lib/apt/lists/*                                                 

RUN rm -rf /var/lib/snapd/seed/snaps/firefox_*.snap && \                        
    add-apt-repository ppa:mozillateam/ppa -s -y && \                           
    echo 'Package: firefox*\nPin: release o=Ubuntu*\nPin-Priority: -1' | tee /etc/apt/preferences.d/firefox-no-snap && \
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox && \
    apt update && \                                                                                                                                   
    apt install -y firefox && \                                                                                                                       
    apt clean && \                                                                                                                                    
    rm -rf /var/lib/apt/lists/* 

# 安装音频支持
RUN apt-get update && apt-get install -y  \
    pavucontrol \
    pulseaudio \
    socat \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    --no-install-recommends && \
    apt-get clean && \                                                          
    rm -rf /var/lib/apt/lists/* 

RUN git clone --depth 1 https://github.com/pikaaQ/noVNC-audio-plugin.git /opt/noVNC-audio-plugin && \
    cp /opt/noVNC-audio-plugin/audio-plugin.js /opt/noVNC/ && \
    sed -i 's/<\/head>/    <script type="module" crossorigin="anonymous" src="audio-plugin.js"><\/script>\n<\/head>/g' /opt/noVNC/vnc.html && \
    sed -i "s/UI.initSetting('path', 'websockify');/UI.initSetting('path', 'websockify?token=vnc');/g" /opt/noVNC/app/ui.js && \
    mkdir -p /etc/websockify/ && \
    echo "load-module module-simple-protocol-tcp listen=127.0.0.1 format=s16le channels=2 rate=48000 record=true playback=false" > /etc/pulse/default.pa.d/simple-protocol.pa

RUN mv /etc/apt/sources.list /etc/apt/source.list.bak

RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list


EXPOSE 5901 6080

COPY start.sh /start.sh                                                                                                 
RUN chmod +x /start.sh                                                                                                                                
                                                                                                                                                      
ENTRYPOINT ["/start.sh"] 
