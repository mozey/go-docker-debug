FROM go-docker-debug-base

# Setup script
COPY setup.sh /
RUN /bin/bash /setup.sh

# [Start script](https://github.com/phusion/baseimage-docker#running-scripts-during-container-startup)
RUN mkdir -p /etc/my_init.d
COPY start.sh /etc/my_init.d/start.sh
RUN chmod +x /etc/my_init.d/start.sh

# [Enable SSH](https://github.com/phusion/baseimage-docker#enabling-ssh)
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

## Install ssh key
COPY id_rsa.pub /tmp/id_rsa.pub
RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys
RUN rm -f /tmp/id_rsa.pub
#RUN /usr/sbin/enable_insecure_key

CMD ["/sbin/my_init"]

