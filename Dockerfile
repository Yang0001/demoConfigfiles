FROM ubuntu:18.04
RUN apt-get update -y
RUN apt-get install wget -y
RUN apt-get install apt-utils  -y
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get install apt-transport-https
RUN apt-get update
RUN apt-get install aspnetcore-runtime-2.2 nginx -y
RUN mkdir /home/ubuntu/ &&\
    mkdir /home/ubuntu/Release &&\
    mkdir /home/ubuntu/Release/logs
COPY published/ /home/ubuntu/Release/
COPY Configfiles/*.sh  /home/ubuntu/Release/
COPY Configfiles/default  /etc/nginx/sites-available/
