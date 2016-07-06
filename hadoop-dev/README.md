# hadoop-dev
Hadoop Developer support for Eclipse Che

Designed to fit within the Codenvy free tier (4 GiB RAM) and run on a single VM.  All tools are installed in local mode which operates with the exact code base as a cluster.  Please don't try to run pseudo-distributed mode as this is **not** supported.

Current Hadoop components installed:
* hadoop client
* hive
* flume-ng
* sqoop
* pig

All components work by executing the normal command as documented in their respective project pages.  If you need additional Hadoop components installed please log an issue here: https://github.com/LamdaFu/dockerfiles/issues 

Installing any additional Hadoop components may make the image exceed the minimal footprint allowed for the Codenvy free tier.
