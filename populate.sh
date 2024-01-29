#!/bin/bash

while :
do
    GAUGE_EC01=$(( ( RANDOM % 50 )  + 1 ))
    echo "send [*] ec01: ${GAUGE_EC01}"
    # with Librato-style tags
    echo -n "myapp.error#type=critical,host=ec01:${GAUGE_EC01}|g" > /dev/udp/statsd_exporter/9125

    GAUGE_EC02=$(( ( RANDOM % 50 )  + 1 ))
    echo "send [*] ec02: ${GAUGE_EC02}"
    # with Librato-style tags
    echo -n "myapp.error#type=critical,host=ec02:${GAUGE_EC02}|g" > /dev/udp/statsd_exporter/9125

    echo increase
    # Counter (see https://github.com/statsd/statsd/blob/master/docs/metric_types.md)
    # with Librato-style tags
    echo -n "myapp.event.total#name=request,host=ec03:1|c" > /dev/udp/statsd_exporter/9125

    sleep $1
done
