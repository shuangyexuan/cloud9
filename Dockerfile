FROM centos:latest
RUN yum update -y \
  && yum install git -y \
  && yum install wget -y\
  && yum install which -y\
  && yum groupinstall -y development\
  && yum install glibc-static -y\
  && yum install epel-release -y\
  && yum install nginx -y
RUN mkdir /cloud9
WORKDIR /cloud9
RUN git clone https://github.com/c9/core.git
RUN wget https://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.xz
RUN xz -d node-v*
RUN tar  --strip-components 1 -xvf  node-v* -C /usr/local
WORKDIR /cloud9/core
RUN scripts/install-sdk.sh
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./init.sh /init.sh
CMD /init.sh
