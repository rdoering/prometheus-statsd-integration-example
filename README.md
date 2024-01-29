
Prometheus and statsd metrics integration example
--------------------------------------------------

Simple example of how to integrate statsd metrics on prometheus.

## How does it work

We have 2 pieces here, [Prometheus](http://prometheus.io/) and the key of the integration
[statsd exporter](https://github.com/prometheus/statsd_exporter) with this.

Our scripts inserts random metrics on statsd (http://127.0.0.1:8125), this metrics are 2 gauges and one counter:

* `myapp.error#type=critical,host=ec01:${GAUGE_EC01}|g`
* `myapp.error#type=critical,host=ec02:${GAUGE_EC02}|g`
* `myapp.event.total#name=request,host=ec03:1|c`

The **statsd exporter** receives the message with the Librato-style tags and translates it into Prometheus 
metrics like:

* `myapp_event_total{host="ec03",name="request"} 1670`
* `myapp_error{host="ec01",type="critical"} 31`
* `myapp_error{host="ec02",type="critical"} 27`

And serves the metrics to prometheus on http://127.0.0.1:9102/metrics prometheus
will scrape this metrics and serve them on http://127.0.0.1:9090

In a grapth:
    
![img.png](img.png)

## Requirements

* docker
* docker-compose

## Run

Just start the docker compose environment:

```
docker compose up
```
