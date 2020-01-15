FROM debian:10.2-slim

RUN apt-get update \
 #
 # Install basic admin tools
 && apt-get install --no-install-recommends --assume-yes sudo curl ca-certificates \
 #
 # Install networking tools
 && apt-get install --no-install-recommends --assume-yes iproute2 nmap ncat tshark ethtool \
 #
 # Clean up
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* /tmp/*

COPY --chown=root:root etc/profile.d/* /etc/profile.d/

COPY --chown=root:root entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/bin/bash" ]
