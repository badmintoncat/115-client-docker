FROM jlesage/baseimage-gui:ubuntu-20.04
LABEL maintainer="lampoppa <lampooppa@gmail.com>"
ENV APP_NAME="115pc"
ENV APP_VERSION="v35.30.0"
ENV USER_ID=0
ENV GROUP_ID=0
ENV ENABLE_CJK_FONT=1
ENV DISPLAY_WIDTH="1920"
ENV DISPLAY_HEIGHT="1080"
ENV APT_SOURCE_HOST="mirrors.ustc.edu.cn"

RUN sed -i "s/archive.ubuntu.com/${APT_SOURCE_HOST}/g" /etc/apt/sources.list
RUN apt-get update -y && apt-get upgrade -y

RUN groupadd -r messagebus || true

RUN dpkg-statoverride --remove /var/run/dbus 2>/dev/null || true

RUN apt-get install -y \
    curl \
    locales \
    wget \
    gdebi-core \
    # Chinese fonts (fix for missing CJK characters)
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    fonts-noto-cjk \
    fontconfig \
    # D-Bus system (fix for bus connection errors)
    dbus \
    dbus-x11 \
    # libcurl (fix for missing libcurl.so.4.6.0)
    libcurl4 \
    libcurl4-openssl-dev \
    # Previous dependencies
    libnss3 \
    libdbus-1-3 \
    # Graphics/Mesa dependencies
    libgbm1 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    mesa-utils \
    # Other GUI dependencies
    libxss1 \
    libgconf-2-4 \
    libxtst6 \
    libxrandr2 \
    libasound2 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libcairo-gobject2 \
    libgtk-3-0 \
    libgdk-pixbuf2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Configure locales and fonts
RUN export LANG=zh_CN.UTF-8 && locale-gen zh_CN.UTF-8
RUN echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
RUN fc-cache -fv

RUN curl https://down.115.com/client/115pc/lin/115br_${APP_VERSION}.deb -o /tmp/115pc_${APP_VERSION}.deb
RUN dpkg -i /tmp/115pc_${APP_VERSION}.deb

# Add D-Bus initialization script
COPY init-dbus.sh /etc/cont-init.d/99-init-dbus.sh
RUN chmod +x /etc/cont-init.d/99-init-dbus.sh

COPY startapp.sh /startapp.sh
