FROM centos:centos8
VOLUME /opt
ADD inotify-count.sh /opt/inotify-count.sh
CMD ["/opt/inotify-count.sh"]
