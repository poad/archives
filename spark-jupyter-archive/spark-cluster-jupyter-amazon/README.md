# Spark Cluster by Docker with docker-compose

## Middleware version
- Apache Spark 2.2.0
- Apache Hadoop 2.7.3
- Apache Hive 2.3.0
- OpenJDK 8
- Amazon Linux

## Useage
```
docker-compose up -d
```

```
docker exec -it spark-master spark-submit --class org.apache.spark.examples.SparkPi --files /usr/local/spark/conf/metrics.properties --master yarn-cluster --master spark://master:7077 /usr/local/spark/lib/spark-examples-2.2.0-hadoop2.7.0.jar
```
