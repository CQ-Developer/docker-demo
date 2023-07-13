FROM ubuntu:latest
RUN adduser --system --no-create-home --disabled-password --disabled-login --shell /bin/sh example
USER example
CMD printf "Container running as: %s\n" $(id -u -n) && \
    printf "Effectively running whoami as: %s\n" $(whoami)