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
COPY Publish/ /home/ubuntu/Release/
COPY Config/*.sh  /home/ubuntu/Release/
COPY Config/default  /etc/nginx/sites-available/
RUN chmod +x /home/ubuntu/Release/start.sh 
RUN chmod +x /home/ubuntu/Release/stop.sh 

