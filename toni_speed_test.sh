#!/bin/bash

# URL of the file to download for the speed test
file_url="https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-large-zip-file.zip"

echo "Running speed test..."
# Infinite loop to perform the speed test
while true; do

    # Use curl to download the file and measure the time
    download_info=$( (time -p curl -o /dev/null -s -w "%{size_download} %{time_total}" $file_url) 2>&1 ) >/dev/null

    # Extract the download size in bytes
    download_size=$(echo "$download_info" | awk '{print $1}') >/dev/null

    # Extract the total time taken
    total_time=$(echo "$download_info" | awk '{print $2}') >/dev/null

    # Calculate the download speed in bytes per second
    download_speed=$(awk "BEGIN {printf \"%.2f\", $download_size / $total_time}") >/dev/null

    # Display the results
    echo "X $total_time seconds, Speed: $download_speed bytes/s"

    
    # Sleep for a short interval before the next iteration
    sleep 1
    break
done
