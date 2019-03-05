#!/bin/sh
APP_NAME=Unime.API.Admin.dll
echo "start begin..."
echo $APP_NAME

cd /home/ubuntu/Release/
nohup  dotnet $APP_NAME >>/home/ubuntu/Release/logs/info.log 2>>/home/ubuntu/Release/logs/error.log &
cd ..

sleep 5

if test $(pgrep -f $APP_NAME|wc -l) -eq 0
then
   echo "start failed"
else
   echo "start successed"
fi
