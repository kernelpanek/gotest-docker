FROM centos:latest

ADD installgo.sh /tmp/installgo.sh
RUN chmod +x /tmp/installgo.sh
RUN /tmp/installgo.sh
