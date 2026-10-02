FROM wine-base:10.14

ARG DEB_PATH
ARG REQUIRED_PACKAGES

USER root
WORKDIR /root

RUN --mount=type=bind,source=./distdir/,target=/root/distdir \
    { if [ -n "${DEB_PATH}" ]; then apt install -y ${DEB_PATH}; fi; }                       && \
    { if [ -n "${REQUIRED_PACKAGES}" ]; then apt install -y ${REQUIRED_PACKAGES};  fi; }    && \
    apt clean

USER debian
WORKDIR /home/debian

CMD [ "/bin/bash" ]
