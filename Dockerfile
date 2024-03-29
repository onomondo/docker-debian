FROM debian:11.2-slim

COPY --chown=root:root etc/apt/apt.conf.d/* /etc/apt/apt.conf.d/

RUN apt-get update \
 #
 # Install basic admin tools
 && apt-get install --assume-yes sudo curl ca-certificates gnupg apt-transport-https \
 #
 # Install networking tools
 && apt-get install --assume-yes iproute2 nmap ncat tshark ethtool iputils-ping net-tools iptables \
 #
 # Clean up
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* /tmp/*

COPY --chown=root:root etc/profile.d/* /etc/profile.d/

COPY --chown=root:root entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/bin/bash" ]
