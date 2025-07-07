FROM dorowu/ubuntu-desktop-lxde-vnc

# Remove broken Chrome repo if inherited
RUN rm -f /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y \
    xterm curl git net-tools htop && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# VNC ports and startup
EXPOSE 6080

CMD ["/startup.sh"]