FROM ghcr.io/openlistteam/openlist-git:latest
USER root
RUN mkdir -p /opt/openlist/data && chmod -R 777 /opt/openlist
