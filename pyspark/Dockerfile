# Creates a Spark Standalone Mode with an IPython PySpark kernel.
FROM debian:latest
MAINTAINER gschaetz

RUN apt-get update -y
RUN apt-get install -y apt-utils curl default-jre

ARG SPARK_VERSION=2.4.5
ARG SCALA_VERSION=2.12.7
ARG HADOOP_VERSION=2.6

# Java
RUN apt-get install -y default-jre
RUN echo $JAVA_HOME

# Scala
RUN curl -o /tmp/scala.tgz https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz  \
&& cd /tmp/ \
&& tar xvf /tmp/scala.tgz \
&& mv /tmp/scala-${SCALA_VERSION} /usr/local/scala 
ENV PATH = $PATH:/usr/local/scala/bin

# Spark
RUN curl -LO http://apache.mirror.anlx.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
&& tar xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/lib \
&& rm -f spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz 
ENV PATH = $PATH:/usr/lib/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}/bin/
ENV SPARK_HOME=/usr/lib/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}

COPY ./log4j.properties ${SPARK_HOME}/conf/log4j.properties

# Pyspark
RUN apt-get install -y python-pip \
&& pip install pyspark jupyter

# Utilities
RUN apt-get install -y vim

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

EXPOSE 7077 8080 8081 8888

ENTRYPOINT ["/bin/bash"]
