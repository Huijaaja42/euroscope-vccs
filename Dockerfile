FROM debian:stable

COPY libts3server_linux_x86.so /bin/
COPY packaging-ests3_1.0-1_i386.deb .
COPY start.sh /usr/local/bin/

RUN dpkg --add-architecture i386
RUN apt-get clean && apt-get update && apt-get upgrade -y

RUN apt-get install locales -y
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get install libc6:i386 -y
RUN dpkg -i packaging-ests3_1.0-1_i386.deb
RUN rm packaging-ests3_1.0-1_i386.deb

EXPOSE 9988

WORKDIR /opt/EuroScopeTs3Server

ENTRYPOINT [ "start.sh" ]
