#!/bin/bash

# URL of the file to download (you can change this to any file you want to test)
# FILE_URL="http://ipv4.download.thinkbroadband.com/200MB.zip"
# FILE_URL="http://ipv4.download.thinkbroadband.com/100MB.zip"
# FILE_URL="http://ipv4.download.thinkbroadband.com/50MB.zip"
# FILE_URL="https://ash-speed.hetzner.com/100MB.bin"
FILE_URL="https://files.testfile.org/ZIPC/150MB-Corrupt-Testfile.Org.zip"

while true; do

    # sudo dscacheutil -flushcache
    # sudo killall -HUP mDNSResponder

    # Measure the time and speed using curl
    result=$(curl -s -o /dev/null -w "%{time_total} %{speed_download}" $FILE_URL)

    # Extract time and speed from the result
    time_taken=$(echo $result | cut -d' ' -f1)
    time_taken=$(echo "scale=1; $time_taken / 1" | bc)
    
    speed=$(echo $result | cut -d' ' -f2)
    speed_mbps=$(echo "scale=1; $speed / 1000 / 1000 * 8" | bc)


    # Print the result in the specified format
    current_time=$(date +"%T")

    # Print the result in the specified format
    # echo "$current_time        Dauer: $time_taken        Geschwindigkeit: $speed_mbps MBit/s"




    time_taken=$(echo $time_taken | tr '.' ',')
    speed_mbps=$(echo $speed_mbps | tr '.' ',')
    echo "$current_time;$time_taken;$speed_mbps"

    # sleep 5
done
