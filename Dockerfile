FROM ubuntu:22.04

ARG S6_OVERLAY_VERSION=3.1.6.2

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	cron \
	curl \
	nano \
	openssh-server \
	pigz \
	tar \
	util-linux \
	xz-utils\
	wget
	
RUN useradd -M -s /usr/sbin/nologin syslog
RUN useradd -M -s /usr/sbin/nologin sysllog

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/syslogd-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/syslogd-overlay-noarch.tar.xz

COPY s6-overlay/ /etc/s6-overlay

ENTRYPOINT [ "/init" ]

