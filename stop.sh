#!/bin/sh
APP_NAME=S3TestWebApi.dll

PROCESS=`ps -ef|grep $APP_NAME|grep -v grep  |awk '{ print $2}'`
while :
do
  kill -9 $PROCESS > /dev/null 2>&1
  if [ $? -ne 0 ];then
   break
  else
   continue
fi
done

echo 'stop success!'
