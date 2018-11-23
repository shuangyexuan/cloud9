FROM centos:latest
RUN yum update -y
RUN yum install git -y
RUN mkdir /cloud9
WORKDIR /cloud9
RUN git clone https://github.com/c9/core.git
RUN yum install wget -y
RUN wget https://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.xz
RUN xz -d node-v*
RUN tar  --strip-components 1 -xvf  node-v* -C /usr/local
RUN yum install which -y
RUN yum groupinstall -y development
RUN yum install glibc-static -y
WORKDIR /cloud9/core
RUN scripts/install-sdk.sh
RUN yum install epel-release -y
RUN yum install nginx -y
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./init.sh /init.sh
CMD /init.sh
