#!/bin/bash
echo "Found first bash script" > tested.txt
#gps_time="0"
#gps_lat="0"
#gps_lon="0"
#error_val="gps_disconneced"

str=$(head -50 /dev/ttyACM0 | grep GPGGA)

gps_valid=$(echo $str | cut -f7 -d,)

if [ "$gps_valid" = "0" ]
then
  gps_time="0"
  gps_lat="0"
  gps_lon="0"  
  error_val="error:GPS-disconnected"
else
  gps_time=$(echo $str | cut -f2 -d,)
  gps_lat=$(echo $str | cut -f3 -d,)
  gps_lat="${gps_lat}"$(echo $str | cut -f4 -d,)
  gps_lon=$(echo $str | cut -f5 -d,)
  gps_lon="${gps_lon}"$(echo $str | cut -f6 -d,)
  error_val="0"
fi

echo "$gps_lat,$gps_lon,$gps_time" > tested.txt

counter=0
name="self"
velocity=0
steering_angle=0
accel=0

echo "passing to php file: $gps_lat $gps_lon $gps_time"
php -f update_registry.php  $gps_lat $gps_lon $gps_time $error_val > all_data.txt
#done < "$1"
echo "Registry Updated."
