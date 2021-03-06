# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.12

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
# @see update 2014/08/10 21:51:26
#CMD ["/sbin/my_init"]

# ...put your own build instructions here...


#--------------------------------------------------------------------------------
#       2014/08/09 21:12:41 customizations

MAINTAINER Paul Michalet <paul.michalet@gmail.com>

#       Install Gogs v0.4.2
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get install wget unzip git -y && \
    cd /tmp && \
    wget https://github.com/gogits/gogs/releases/download/v0.4.2/linux_amd64.zip && \
    unzip linux_amd64.zip && \
    rm -f linux_amd64.zip && \
    mv /tmp/gogs /gogs-0.4.2

#       Runit entry (make sure gogs.sh is chmod +x)
#RUN mkdir -p /etc/my_init.d
#ADD gogs.sh /etc/my_init.d/gogs.sh

#       update 2014/08/10 21:50:43 - WTF is this not working
#       -> test moving CMD at the end
RUN mkdir /etc/service/gogs
ADD gogs.sh /etc/service/gogs/run
CMD ["/sbin/my_init"]

#       Private port
EXPOSE 3000




#--------------------------------------------------------------------------------
#       end 2014/08/09 21:12:41 customizations

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*